# frozen_string_literal: true

module Payments
  module Payu
    class Failure
      attr_reader :payment, :status, :options

      def initialize(payment, status)
        @payment = payment
        @status = status
      end

      def self.call(payment, status)
        new(payment, status).call
      end

      def call
        return ServiceResponse.success(data: payment) if payment.update(status: Payment.payu_status(status))

        ServiceResponse.error(message: 'Payment update failed', data: payment)
      end
    end
  end
end
