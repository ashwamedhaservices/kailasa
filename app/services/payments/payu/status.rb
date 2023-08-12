# frozen_string_literal: true

module Payments
  module Payu
    class Status < Base
      attr_reader :payment

      def call
        return unless payment.finalized?

        response = RestRequestHandler.new(status_api_base_url).post(status_api)
        Rails.logger.info("payment status fetch failed: #{response.body}") unless response.status.eql?(200)

        update_payment_status(response.body[payment.uuid])
      end

      private

      def update_payment_status(params)
        Payu::Success.call(payment, params[:unmappedstatus], success_options(params)) if params[:status] == 'success'
        Payu::Failure.call(payment, params[:unmappedstatus])
      end

      def success_options(params)
        { mode: params[:mode], pg_transaction_no: params[:bank_ref_num], txn_reference_no: params[:mihpayid],
          settlement_time: params[:addedon], notes: params[:bankcode] }
      end

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
