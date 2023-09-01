# frozen_string_literal: true

module Admin
  module Api
    module V1
      class NomineesController < ApplicationController
        def show
          @nominee = Nominee.find(params[:id])
          render json: success(data: @nominee), status: :ok
        end
      end
    end
  end
end
