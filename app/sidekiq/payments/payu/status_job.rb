# frozen_string_literal: true

module Payments
  module Payu
    class StatusJob
      include Sidekiq::Job

      def perform(payment_id)
        Payments::Payu::Status.call(Payment.find(payment_id))
      end
    end
  end
end
