# frozen_string_literal: true

module Users
  module Create
    class CreateSubscription
      include Interactor
      delegate :user, to: :context

      def call
        subscription_status_change_fail unless activate_trial.success?

        user.subscribed = true
        user_subscription_status_change_fail unless user.save
      end

      private

      def unsubscribed
        Subscriptions::Purchase.call(user, :unsubscribed)
      end

      def activate_trial
        @activate_trial ||= unsubscribed # Subscriptions::ActivateTrial.call(user)
      end

      def subscription_status_change_fail
        context.fail!(error: activate_trial.msg, code: ::Errors::Handler.code('subscription_change_failed'))
      end

      def user_subscription_status_change_fail
        context.fail!(error: user.errors.full_messages.to_sentence,
                      code: ::Errors::Handler.code('subscription_change_failed'))
      end
    end
  end
end
