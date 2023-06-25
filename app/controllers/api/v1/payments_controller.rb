# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :authorize_user!

      def create
        @result = Payments::Create.call(current_user)
        return render json: success(data:), status: :ok if success?

        render json: failure(msg:, error_code:), status: :bad_request
      end

      def callback
        Rails.logger.info "response: #{params}"
      end

      def return_url
        Rails.logger.info "response: #{params}"
      end
    end
  end
end
