# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ::ApplicationController
      before_action :set_paper_trail_whodunnit
      before_action :authorize_user!
    end
  end
end
