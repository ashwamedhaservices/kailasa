# frozen_string_literal: true

module Api
  module V2
    class PaymentsController < ApplicationController
      def configs
        json_success(data: Payments::Configs.json)
      end

      def create
        return handle_payu_payment if create_params[:gateway].eql?('payu')

        handle_hdfc_payment
      end

      private

      def create_params
        params.permit(:gateway)
      end

      def handle_payu_payment
        response = Payments::Payu::Create.call(current_user)
        return json_success(data: response.data) if response.success?

        json_failure(msg: response.msg)
      end

      def handle_hdfc_payment
        response = Payments::PgHdfc::Create.call(current_user)
        return json_success(data: response.data) if response.success?

        json_failure(msg: response.msg)
      end
    end
  end
end
