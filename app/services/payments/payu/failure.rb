# frozen_string_literal: true

module Payments
  module Payu
    class Failure < Base
      attr_reader :status, :options

      def initialize(payment, status)
        @status = status
        super(payment)
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
