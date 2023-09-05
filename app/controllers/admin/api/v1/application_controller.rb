# frozen_string_literal: true

module Admin
  module Api
    module V1
      class ApplicationController < ::ApplicationController
        before_action :authorize_user!
      end
    end
  end
end
