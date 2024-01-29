# frozen_string_literal: true

module Payments
  module PgHdfc
    class Status
      extend Callable
      include Service
      include Crypto

      attr_reader :payment, :response_hash

      delegate :user, :payment_gateway, to: :payment

      def initialize(payment)
        @payment = payment
        @response_hash = { status: '', enc_response: '', enc_error_code: '' }
      end

      def call
        Rails.logger.info("calling status api for payment #{payment.id}")
        Rails.logger.info("url for status fetch is #{url} for payment_id #{payment.id}")

        check_and_update_status
      rescue StandardError => e
        Rails.logger.error("error in status api for payment #{payment.id} error: #{e} #{e.backtrace}")
        error(msg: 'error in status api for payment')
      end

      private

      def check_and_update_status
        call_and_parse_hdfc_status_api
        Rails.logger.info("response hash is #{response_hash}")
        if response_hash[:status].to_i.zero?
          Rails.logger.info("hdfc success payment_id #{payment.id} the dec_rsp: #{decoded_response}, params #{params}")
          return api_success
        end
        api_failed
      end

      def api_success
        if payment.update(params)
          Payments::PaymentSuccess.new(user).subscribe if payment.success?
          return success(msg: 'updated payment successfully', data: payment)
        end
        error(msg: 'failed to update payment', data: payment)
      end

      def api_failed
        Rails.logger.info("api call for payment status failed payment_id #{payment.id}")
        Rails.logger.info("api response is #{response_hash[:enc_response]}, code: #{response_hash[:enc_error_code]}")
        error(msg: 'api call failed for payment status')
      end

      def call_and_parse_hdfc_status_api
        call_status_api.split('&').each do |entry|
          key, value = entry.split('=')
          response_hash[key.to_sym] = value
        end
      end

      def call_status_api
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(url)
        response = https.request(request)
        response.read_body
      end

      def url
        @url ||= URI("#{Rails.application.credentials.dig(:pg, :hdfc, :status_enquiry_api)}?#{payload}")
      end

      def payload
        "enc_request=#{enc_request}&access_code=#{payment_gateway.api_key}&request_type=JSON&response_type=JSON" \
          '&command=orderStatusTracker&version=1.2'
      end

      def enc_request
        encrypt(request.to_json, payment_gateway.secret)
      end

      def request
        {
          reference_no: '',
          order_no: payment.uuid
        }
      end

      def decoded_response
        @decoded_response ||= JSON.parse(decrypt(response_hash[:enc_response].chomp, payment_gateway.secret))
      end

      def params
        {
          status: Payment.status_from_hdfc_api(decoded_response['order_status']),
          mode: Payment.mode_from_hdfc_api(decoded_response['order_option_type']),
          platform: :android,
          settlement_time: decoded_response['order_status_date_time'],
          pg_transaction_no: decoded_response['reference_no'],
          txn_reference_no: decoded_response['order_bank_ref_no'],
          notes: decoded_response['order_notes'],
          err: decoded_response['error_desc']
        }.compact
      end
    end
  end
end
