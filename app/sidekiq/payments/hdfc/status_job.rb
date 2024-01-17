# frozen_string_literal: true

module Payments
  module Hdfc
    class StatusJob
      include Sidekiq::Job

      sidekiq_options queue: :default

      def perform(payment_id)
        payment = Payment.find_by(id: payment_id)
        return Rails.logger.error("status_job: payment not found for the id #{payment_id}") unless payment

        Payments::PgHdfc::Status.call(payment)
      end
    end
  end
end
