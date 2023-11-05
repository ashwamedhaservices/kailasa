# frozen_string_literal: true

module Payments
  module Payu
    class StatusJob
      include Sidekiq::Job

      sidekiq_options queue: :critical

      def perform(payment_id)
        payment = Payment.find_by(id: payment_id)
        return Rails.logger.error("status_job: payment not found for the id #{payment_id}") unless payment

        Payments::Payu::Status.call(payment)
      end
    end
  end
end
