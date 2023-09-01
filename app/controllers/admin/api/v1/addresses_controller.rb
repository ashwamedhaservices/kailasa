# frozen_string_literal: true

module Admin
  module Api
    module V1
      class AddressesController < ApplicationController
        def show
          @address = Address.find(params[:id])
          render json: success(data: @address), status: :ok
        end
      end
    end
  end
end
