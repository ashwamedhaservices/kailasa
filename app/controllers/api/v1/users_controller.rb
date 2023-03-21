# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        render json: { hi: 'hello' }, status: :ok
      end
    end
  end
end
