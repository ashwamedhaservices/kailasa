# frozen_string_literal: true

module Users
  module Create
    class SendOtp
      include Interactor
      delegate :params, :user, to: :context

      def call
        # sms client trigger sms here
        # # send async here
        send_verification_otp
      end

      def send_verification_otp
        Notification::Sms.trigger sms_params
        Rails.logger.info 'Sending OTP'
      end

      def sms_params
        {
          mobile: user.mobile_number,
          template_type: 'sign_up',
          params: { 'otp' => Otp.generate!(user, 'mobile') }
        }
      end
    end
  end
end
