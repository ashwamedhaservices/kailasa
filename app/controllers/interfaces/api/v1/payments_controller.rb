# frozen_string_literal: true

module Interfaces
  module Api
    module V1
      class PaymentsController < ApplicationController
        before_action :authenticate_service_token!, except: %i[hdfc_return_url]

        def hdfc_return_url
          response = Payments::PgHdfc::ParseReturnUrl.call(params)
          Rails.logger.info("the response for return url is #{response}, redirect_url #{redirect_url(response.data)}")
          redirect_to redirect_url(response.data), allow_other_host: true
        end

        private

        def redirect_url(payment)
          @redirect_url ||= 'https://www.ashwamedha.net/hdfc_payment_status?' \
                            "order_id=#{payment.uuid}&status=#{payment.status}&amount=#{payment.amount}"
        end
      end
    end
  end
end
