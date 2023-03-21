# frozen_string_literal: true

module Interfaces
  module Api
    module V1
      class ApplicationController < ::ApplicationController
        before_action :authenticate_service_token!
      end
    end
  end
end
