# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :authorize_user!, except: %i[return_url callback]

      def create
        @result = Payments::Payu::Create.call(current_user)
        return render json: success(data:), status: :ok if success?

        render json: failure(msg:, error_code:), status: :bad_request
      end

      def callback
        Rails.logger.info "response: #{params}"
        render json: success(data: params), status: :ok
      end

      def return_url
        @result = Payments::Payu::ParseReturnUrl.call(return_url_params)
        if data.status == 'success'
          Payments::PaymentSuccess.new(data.user).subscribe
          return redirect_to 'https://ashwamedhaservices.com/payments/payu/response?status=success',
                             allow_other_host: true
        end

        redirect_to 'https://ashwamedhaservices.com/payments/payu/response?status=failure', allow_other_host: true
      end

      private

      def return_url_params
        params.permit(:mihpayid, :mode, :bankcode, :status, :unmappedstatus, :key, :error, :error_message,
                      :bank_ref_num, :txnid, :amount, :PG_TYPE, :addedon)
      end
    end
  end
end
