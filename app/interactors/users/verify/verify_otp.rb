# frozen_string_literal: true

module Users
  module Verify
    class VerifyOtp
      include Interactor
      delegate :params, :user, to: :context

      def call
        return if Otp.verify!(params[:otp], verify_options)

        # unless response.success?
        context.fail!(error: 'Invalid OTP entered', code: ::Errors::Handler.code('wrong_otp')) 
      end

      private

      def verify_options
        {}.tap do |options|
          options[:user_id] = user.id
          options[:receiver] =  user.mobile_number
          options[:otp_type] =  'register'
        end
      end
    end
  end
end
