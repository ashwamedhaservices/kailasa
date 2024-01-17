# frozen_string_literal: true

module Payments
  module PgHdfc
    class Create
      extend Callable
      include Service
      include Crypto

      attr_reader :user

      delegate :subscription, to: :user

      def initialize(user)
        @user = user
      end

      def call
        Subscriptions::Models::Payments.call(payment, 'one_year')
        return payment_saved_successfully if payment.save!

        error(msg: 'unable to create payment for hdfc', data: payment)
      end

      private

      def payment
        @payment ||= user.payments.new(subscription_id: subscription.id, payment_gateway_id: payment_gateway.id)
      end

      def payment_gateway
        @payment_gateway ||= PaymentGateway.find_by(name: 'pg_hdfc')
      end

      def enc_payment_string
        @enc_payment_string ||= encrypt(payment_string, payment_gateway.secret)
      end

      def payment_string
        @payment_string ||= "merchant_id=#{payment_gateway.partner_id}&order_id=#{payment.uuid}" \
                            "&amount=#{payment.amount}&currency=INR&redirect_url=#{payment_gateway.success_url}" \
                            "&cancel_url=#{payment_gateway.failure_url}&language=EN&billing_name=#{user.full_name}" \
                            "&merchant_param1=#{user.id}&merchant_param2=#{user.mobile_number}"
      end

      def success_data
        { url: Rails.application.credentials.dig(:pg, :hdfc, :initiate_transaction_api),
          enc_data: enc_payment_string,
          api_key: payment_gateway.api_key }
      end

      def payment_saved_successfully
        Payments::Hdfc::StatusJob.perform_in(30.minutes, payment.id)
        Rails.logger.info("the payment string for user_id #{user.id} is #{payment_string} payment_id: #{payment.id}")
        success(data: success_data)
      end
    end
  end
end
