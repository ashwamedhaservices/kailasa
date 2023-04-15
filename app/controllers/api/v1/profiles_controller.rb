# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < ApplicationController
      def dashboard
        @interactor = Profiles::DashboardService.new(current_profile).call
        Rails.logger.info("this is data #{@interactor}")
        if @interactor.success
          render json: success(data: @interactor), status: :ok
        else
          render json: failure(msg: error, error_code: code), status: :unprocessable_entity
        end
      end
    end
  end
end
