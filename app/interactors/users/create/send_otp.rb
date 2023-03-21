module Users
  module Create
    class SendOtp
      include Interactor
      delegate :params, :user, to: :context
      
      def call
        # sms client trigger sms here
      end
    end
  end
end
