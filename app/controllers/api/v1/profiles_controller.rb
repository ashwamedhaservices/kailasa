# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < ApplicationController
      def dashboard
        @result = Profiles::DashboardService.new(current_profile).call
        Rails.logger.info("this is data #{result}")
        return render json: success(data:), status: :ok if success?

        render json: failure(msg:, error_code:), status: :unprocessable_entity
      end
    end
  end
end
