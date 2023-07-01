# frozen_string_literal: true

module Payments
  module Payu
    class Status < Base
      attr_reader :payment

      def self.call(payment)
        new(payment).call
      end

      def call
        RestRequestHandler.new(status_api_base_url).post(status_api)
      end

      private

      def payload
        {
          key: payment_gateway.api_key,
          command: 'verify_payment',
          var1: payment.uuid,
          hash:
        }
      end

      def headers
        {
          Accept: 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      end

      def hash
        hash(hash_string)
      end

      def hash_string
        "#{payment_gateway.api_key}|verify_payment|#{payment.uuid}|#{payment_gateway.secret}"
      end
    end
  end
end
