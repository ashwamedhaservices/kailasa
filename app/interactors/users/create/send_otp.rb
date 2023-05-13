# frozen_string_literal: true

module Users
  module Create
    class SendOtp
      include Interactor
      delegate :params, :user, to: :context

      def call
        # sms client trigger sms here
        Otp.generate!(user, 'register')
        # # send async here
      end
    end
  end
end
