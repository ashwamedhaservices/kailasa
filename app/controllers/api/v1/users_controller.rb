class Api::V1::UsersController < ApplicationController
  before_action :authorize_user!
  skip_before_action :authorize_user!, only: %i[create verify]
  # POST accounts/api/v1/users
  def create
    @interactor = ::Users::Create::Processor.call(params: create_params)
    if success?
      resp = Api::V1::UserSerializer.new(interactor.user).serializable_hash
      i8n_msg = 'Verification OTP sent successfully, please verify.'# TODO: i8n_msg
      render json: success(msg: i8n_msg, data: resp), status: :created
    else
      render json: failure(msg: error, error_code: code), status: :unprocessable_entity
    end
  end

  # POST accounts/api/v1/users#verify
  def verify
    # OTP verify logic goes here
    @interactor = ::Users::Verify::Processor.call(params: verify_params.merge(user: user))
    if success?
      resp = Api::V1::UserSerializer.new(user, params: {issue_token: true}).serializable_hash
      render json: success(data: resp), status: :ok
    else
      render json: failure(msg: error, error_code: code), status: :unprocessable_entity
    end
  end

  def index
    render json: { hi: 'hello' }, status: :ok
  end

  private

  def create_params
    params.require(:users).permit(:mobile_number, :referral_code, :password)
  end

  def verify_params
    @verify_params ||= params.require(:users).permit(:mobile_number, :otp, :id)
  end

  def user
    @user ||= if verify_params[:id]
      ::User.find(verify_params[:id])
    elsif verify_params[:mobile_number]
      ::User.find_by(mobile_number: verify_params[:mobile_number])
    end
  end
end
