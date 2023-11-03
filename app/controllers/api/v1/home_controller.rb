# frozen_string_literal: true

module Api
  module V1
    class HomeController < ApplicationController
      skip_before_action :authorize_user!

      def index; end
    end
  end
end
