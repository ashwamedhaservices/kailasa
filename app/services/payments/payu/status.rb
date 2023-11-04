# frozen_string_literal: true

module Payments
  module Payu
    class Status < Base
      module TransactionStatus
        SUCCESS = 'success'
        FAILURE = 'failure'
        NOTFOUND = 'Not Found'
      end

      def call
        return if payment.finalized?

        response = call_payu_status_api
        update_payment_status(response.body.dig('transaction_details', payment.uuid))
      end

      private

      def call_payu_status_api
        response = RestRequestHandler.new(status_api_base_url).post_form(status_api, payload)
        return response if response.code.eql?(200)

        Rails.logger.error("payment status fetch failed for #{payment.id}")
        Rails.logger.info("payment status fetch failed: #{response.body}")
      end

      def update_payment_status(params)
        return Rails.logger.error("nil recived as update params for #{payment.id}") unless params

        if params[:status].eql?(TransactionStatus::SUCCESS)
          return Payu::Success.call(payment, params['unmappedstatus'], success_options(params))
        end
        return Payu::Failure.call(payment, params['unmappedstatus']) if params[:status].eql?(TransactionStatus::FAILURE)

        handle_edge_case_for_unknown_transaction_status(params)
      end

      def handle_edge_case_for_unknown_transaction_status(params)
        Rails.logger.info("edge case params log for payment status #{params}")
        Rails.logger.error("unknown status recived for paymnet_id: #{payment.id}, status: #{params[:status]}")
        Payu::Failure.call(payment, 'failed')
      end

      def success_options(params)
        { mode: params['mode'],
          pg_transaction_no: params['bank_ref_num'],
          txn_reference_no: params['mihpayid'],
          settlement_time: params['addedon'],
          notes: params['bankcode'] }
      end

      def payload
        {
          key: payment_gateway.api_key,
          command: 'verify_payment',
          var1: payment.uuid,
          hash: hash(hash_string)
        }
      end

      def hash_string
        "#{payment_gateway.api_key}|verify_payment|#{payment.uuid}|#{payment_gateway.secret}"
      end
    end
  end
end
