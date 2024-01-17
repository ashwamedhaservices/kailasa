# frozen_string_literal: true

module Payments
  module PgHdfc
    class ParseReturnUrl
      extend Callable
      include Service
      include Crypto

      attr_reader :params

      def initialize(params)
        @params = params
      end

      # {:order_id=>"3549cfea-7f1e-4c39-98a6-c07c5c9be6a5",
      #  :tracking_id=>"312010656771",
      #  :bank_ref_no=>"1701620564180",
      #  :order_status=>"Success",
      #  :failure_message=>nil,
      #  :payment_mode=>"Credit Card",
      #  :card_name=>"Visa",
      #  :status_code=>"null",
      #  :status_message=>"Y",
      #  :currency=>"INR",
      #  :amount=>"1.00",
      #  :billing_name=>"Alia Bhat",
      #  :billing_address=>nil,
      #  :billing_city=>nil,
      #  :billing_state=>nil,
      #  :billing_zip=>nil,
      #  :billing_country=>nil,
      #  :billing_tel=>nil,
      #  :billing_email=>nil,
      #  :delivery_name=>nil,
      #  :delivery_address=>nil,
      #  :delivery_city=>nil,
      #  :delivery_state=>nil,
      #  :delivery_zip=>nil,
      #  :delivery_country=>nil,
      #  :delivery_tel=>nil,
      #  :merchant_param1=>"14",
      #  :merchant_param2=>"9932798945",
      #  :merchant_param3=>nil,
      #  :merchant_param4=>nil,
      #  :merchant_param5=>nil,
      #  :vault=>"N",
      #  :offer_type=>"null",
      #  :offer_code=>"null",
      #  :discount_value=>"0.0",
      #  :mer_amount=>"1.00",
      #  :eci_value=>"null",
      #  :retry=>"N",
      #  :response_code=>"0",
      #  :billing_notes=>nil,
      #  :trans_date=>"03/12/2023 21:52:43",
      #  :bin_country=>"INDIA"}
      def call
        Rails.logger.info("HDFC response: #{response_hash}")
        if payment.update(payment_params)
          Payments::PaymentSuccess.new(user).subscribe
          return success(msg: 'updated payment successfully', data: payment)
        end

        error(msg: 'failed to update payment', data: payment)
      end

      private

      def payment
        @payment ||= Payment.find_by(uuid: response_hash['order_id'])
      end

      def user
        payment.user
      end

      def response_hash
        @response_hash ||= {}.tap do |hash|
          decrypted_response.split('&').each do |pair|
            key, value = pair.split('=')
            hash[key] = value
          end
        end
      end

      def decrypted_response
        @decrypted_response ||= decrypt(params['encResp'], payment_gateway.secret)
      end

      def payment_gateway
        @payment_gateway ||= PaymentGateway.find_by(name: 'pg_hdfc')
      end

      def payment_params
        {
          status: Payment.status_from_hdfc_response(response_hash['order_status']),
          mode: Payment.mode_from_hdfc_response(response_hash['payment_mode']),
          platform: :android,
          settlement_time: response_hash['trans_date'],
          pg_transaction_no: response_hash['tracking_id'],
          txn_reference_no: response_hash['bank_ref_no'],
          notes: response_hash['billing_notes'],
          err: response_hash['failure_message']
        }
      end
    end
  end
end
