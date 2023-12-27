# frozen_string_literal: true

module Admin
  module Api
    module V1
      class ReportsController < ApplicationController
        before_action :authorize_user!, except: %i[index]

        def index
          json_success(data: Reports::Info.call)
        end
      end
    end
  end
end
