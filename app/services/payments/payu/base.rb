# frozen_string_literal: true

module Payments
  module Payu
    class Base
      extend Callable
      include Service

      attr_reader :payment

      delegate :user, :payment_gateway, to: :payment

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

      # same as product info in create.rb
      def request_product_info
        'app_subscription'
      end

      # same as hash string in create.rb
      def request_hash_string
        "#{payment_gateway.api_key}|#{payment.uuid}|#{payment.amount}|#{request_product_info}|#{user.fname}|#{user.email}|||||||||||#{payment_gateway.secret}" # rubocop:disable Layout/LineLength
      end
    end
  end
end
