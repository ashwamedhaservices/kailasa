# frozen_string_literal: true

module Users
  module Create
    class CreateSubscription
      include Interactor
      delegate :user, to: :context

      def call
        Subscriptions::ActivateTrial.call
      end
    end
  end
end
