# frozen_string_literal: true

module Admin
  module Api
    module V1
      class ApplicationController < ::ApplicationController
        before_action :authorize_user!

        def page_no
          @page_no ||= params[:page_no].to_i || 0
        end

        def invalidate_page_no
          page_no.eql?(-1)
        end

        def record_count
          @record_count ||= params[:record_count].to_i || 20
        end
      end
    end
  end
end
