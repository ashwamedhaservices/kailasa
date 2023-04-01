module Users
  module Verify
    class ValidateParams
      include Interactor
      delegate :params, to: :context
      def call
        context.fail!(error: 'Mobile number missing', code: error_code) unless params[:mobile_number]
        context.fail!(error: 'Please enter a valid OTP', code: error_code) unless params[:otp]
        context.user = params[:user]
      end

      def error_code(error: 'required_params_missing')
        ::Errors::Handler.code(error)
      end
    end
  end
end
