# frozen_string_literal: true

module Payments
  module Payu
    class Success
      attr_reader :payment, :status, :options

      # options {:mode, :pg_transaction_no, :txn_reference_no, :settlement_time}
      def initialize(payment, status, options)
        @payment = payment
        @status = status
        @options = options
      end

      def self.call(payment, status, options)
        new(payment, status, options).call
      end

      def call
        if payment.update(options.merge(status: Payment.payu_status(status)))
          return ServiceResponse.success(data: payment)
        end

        ServiceResponse.error(message: 'Payment update failed', data: payment)
      end
    end
  end
end
