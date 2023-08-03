# frozen_string_literal: true

module Payments
  module Payu
    class Success < Base
      attr_reader :status, :options

      # options {:mode, :pg_transaction_no, :txn_reference_no, :settlement_time, :notes}
      def initialize(payment, status, options)
        super(payment)
        @status = status
        @options = options
      end

      def call
        return success(data: payment) if payment.update(update_params)

        error(message: 'Payment update failed', data: payment)
      end

      private

      def update_params
        options[:mode] = Payment.payu_payment_mode(options[:mode])
        options[:status] = Payment.payu_status(status)
        options[:platform] = :android
        options
      end
    end
  end
end
