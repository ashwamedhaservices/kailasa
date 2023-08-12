# frozen_string_literal: true

module Payments
  module Payu
    class Base
      extend Callable
      include Service

      attr_reader :payment

      def initialize(payment)
        @payment = payment
      end

      def status_api_base_url
        Rails.application.credentials.pg.payu.status_api_base_url
      end

      def status_api
        Rails.application.credentials.pg.payu.status_api
      end

      def hash(hash_string)
        Digest::SHA2.new(512).hexdigest(hash_string)
      end
    end
  end
end
