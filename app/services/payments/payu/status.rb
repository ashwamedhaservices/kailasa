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
        return Rails.logger.info("payment finalized id #{payment.id}") if payment.finalized?

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
        return handle_success_payment(params) if params['status'].eql?(TransactionStatus::SUCCESS)
        return handle_failure_payment(params) if params['status'].eql?(TransactionStatus::FAILURE)

        handle_edge_case_for_unknown_transaction_status(params)
      end

      def handle_success_payment(params)
        Rails.logger.info("updated status of success payment_id #{payment.id} as #{params['unmappedstatus']}")
        Payu::Success.call(payment, params['unmappedstatus'], success_options(params))
      end

      def handle_failure_payment(params)
        Rails.logger.info("updated status of failure payment_id #{payment.id} as #{params['unmappedstatus']}")
        Payu::Failure.call(payment, params['unmappedstatus'])
        ::Payments::PaymentSuccess.new(payment.user).subscribe
      end

      def handle_edge_case_for_unknown_transaction_status(params)
        Rails.logger.info("edge case params log for payment status #{params}")
        Rails.logger.error("unknown status recived for paymnet_id: #{payment.id}, status: #{params['status']}")
        Payu::Failure.call(payment, 'failed')
        Rails.logger.info("updated statue of payment id #{payment.id} as failed")
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
