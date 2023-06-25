# frozen_string_literal: true

module Payments
  class Create
    attr_reader :user

    delegate :subscription, to: :user, prefix: true

    def initialize(user)
      @user = user
    end

    def self.call(user)
      new(user).call
    end

    def call
      one_year_subscription_payment
      return ServiceResponse.success(data: create_response) if payment.save!

      ServiceResponse.error(msg: 'unable to create payment', data: payment)
    end

    private

    def payment
      @payment ||= Payment.new(user_id: user.id, subscription_id: user_subscription.id,
                               payment_gateway_id: payment_gateway.id)
    end

    def one_year_subscription_payment
      payment.for = 'one_year_subscription'
      payment.amount = '359.9'
      payment.status = 'pending'
    end

    def payment_gateway
      @payment_gateway ||= PaymentGateway.first
    end

    def create_response
      {
        user:,
        payment:,
        payment_gateway:
      }
    end
  end
end
