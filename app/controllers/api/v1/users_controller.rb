# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_user!, except: %i[create verify login login_otp otp_verification registered]
      # POST accounts/api/v1/users
      def create
        @interactor = ::Users::Create::Processor.call(params: create_params)
        if success?
          resp = Api::V1::UserSerializer.new(interactor.user).serializable_hash
          i8n_msg = 'Verification OTP sent successfully, please verify.' # TODO: i8n_msg
          render json: success(msg: i8n_msg, data: resp[:data]), status: :created
        else
          render json: failure(msg: error, error_code: code), status: :unprocessable_entity
        end
      end

      # POST accounts/api/v1/users#verify
      def verify
        # OTP verify logic goes here
        return render json: verified_user_error, status: :ok if user.verified?

        @interactor = ::Users::Verify::Processor.call(params: verify_params.merge(user:))
        return render json: success(data: user_login_resp), status: :ok if success?

        render json: failure(msg: error, error_code: code), status: :unprocessable_entity
      end

      # POST accounts/api/v1/users/login
      # expects phone/email and password
      def login
        if user.created?
          unverified_user_error
        elsif user.authenticate(login_params['password'])
          i8n_msg = 'User logged in successfully'
          render json: success(msg: i8n_msg, data: user_login_resp), status: :ok
        else
          i18n_msg = 'Wrong Mobile number or Password entered'
          code = errors_code('invalid_credentials')
          render json: failure(msg: i18n_msg, error_code: code), status: :unauthorized
        end
      end

      # POST accounts/api/v1/users/login_otp
      # OTP request to login
      # TODO: block user if requests too many OTPs
      def login_otp
        Otp.generate!(user, 'login')
        # send OTP async
        i8n_msg = 'Login OTP sent successfully, please verify.' # TODO: i8n_msg
        render json: success(msg: i8n_msg), status: :created
      end

      # POST accounts/api/v1/users/otp_verification
      def otp_verification
        if Otp.verify!(login_params['otp'], verify_options)
          user.mark_verified! if User.last.created?

          i8n_msg = 'Otp verified successfully'
          render json: success(msg: i8n_msg, data: user_login_resp), status: :ok
        else
          render json: failure(msg: 'Incorrect OTP', error_code: errors_code('wrong_otp')), status: :unauthorized
        end
      end

      # GET accounts/api/v1/users/registered
      def registered
        user = User.find_by(mobile_number: params[:mobile_number])
        return render json: success(msg: 'User not found'), status: :ok unless user

        existing_user_error(user)
        # i8n_msg, code = existing_user_error(user)
        # render json: failure(msg: i8n_msg, error_code: code), status: :ok
      end

      def subscribed
        render json: success(data: current_user.subscribed), status: :ok
      end

      private

      def create_params
        params.require(:users).permit(:full_name, :mobile_number, :referral_code, :password)
      end

      def verify_params
        @verify_params ||= params.require(:users).permit(:mobile_number, :otp, :id, :password)
      end

      def login_params
        params.require(:users).permit(:password, :mobile_number, :otp, :id)
      end

      def user
        @user ||= if verify_params[:id]
                    ::User.find(verify_params[:id])
                  elsif verify_params[:mobile_number]
                    ::User.find_by!(mobile_number: verify_params[:mobile_number])
                  end
      end

      def verify_options
        {}.tap do |options|
          options[:user_id] = user.id
          options[:receiver] = user.mobile_number
          options[:otp_type] = 'login'
        end
      end

      def user_login_resp
        Api::V1::UserSerializer.new(user, params: { issue_token: true }).serializable_hash[:data]
      end

      def existing_user_error(user)
        if user.created?
          unverified_user_error
        else
          i8n_msg = 'Mobile number has already been registered, please login.'
          code = errors_code('mobile_number_taken')
          render json: failure(msg: i8n_msg, error_code: code), status: :ok
        end
      end

      def verified_user_error
        failure(msg: 'Mobile number already verified pls, login', error_code: errors_code('already_verified_user'))
      end

      def unverified_user_error
        Otp.generate!(user, 'login')
        Otp.generate!(user, 'register')
        # send OTP async
        i8n_msg = 'Mobile number verification pending, please enter otp'
        code =  errors_code('mobile_verification_pending')
        render json: failure(msg: i8n_msg, error_code: code, data: { id: user.id }), status: :ok
      end
    end
  end
end
