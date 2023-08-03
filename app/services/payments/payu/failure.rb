# frozen_string_literal: true

module Payments
  module Payu
    class Failure < Base
      attr_reader :status, :options

      def initialize(payment, status)
        @status = status
        super(payment)
      end

      def call
        return success(data: payment) if payment.update(status: Payment.payu_status(status))

        error(message: 'Payment update failed', data: payment)
      end
    end
  end
end
