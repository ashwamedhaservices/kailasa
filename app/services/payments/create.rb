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
      payment.uuid = SecureRandom.uuid
      payment.for = 'one_year_subscription'
      payment.amount = '359.9'
      payment.status = 'pending'
    end

    def payment_gateway
      @payment_gateway ||= PaymentGateway.first
    end

    def create_response # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      {
        key: payment_gateway.api_key,
        txnid: payment.uuid,
        productinfo: product_info,
        amount: payment.amount,
        email: payment.amount,
        firstname: user.fname,
        lastname: user.lname,
        hash:,
        surl: payment_gateway.success_url,
        furl: payment_gateway.failure_url
      }
    end

    def product_info
      'app_subscription'
    end

    def hash
      Digest::SHA2.new(512).hexdigest(hash_string)
    end

    def hash_string
      "#{payment.uuid}||#{payment.amount}||#{product_info}||#{user.fname}||#{user.email}||||||||||||#{payment_gateway.secret}" # rubocop:disable Layout/LineLength
    end
  end
end
