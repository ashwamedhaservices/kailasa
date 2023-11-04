# frozen_string_literal: true

module Payments
  module Payu
    class Status < Base
      def call
        return if payment.finalized?

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
          hash: hash(request_hash_string)
        }
      end
    end
  end
end
