# frozen_string_literal: true

module Subscriptions
  module Models
    class Payments
      extend Callable
      include Service

      attr_reader :payment, :type

      def initialize(payment, type)
        @payment = payment
        @type = type
      end

      def call
        return error(msg: 'subscription type not found') unless respond_to?(type)
        return error(msg: 'Payment not found') if payment.blank?

        send(type)
      end

      # private

      def one_year
        payment.uuid = SecureRandom.uuid
        payment.for = 'one_year_subscription'
        payment.amount = Rails.application.credentials.subscriptions.price
        payment.status = 'initiated'
        success(msg: 'made payment for one year subscription')
      end
    end
  end
end
