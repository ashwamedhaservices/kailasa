# frozen_string_literal: true

module Api
  module V1
    class ReferralsController < ApplicationController
      before_action :authorize_user!, except: %i[index]

      def index
        Rails.logger.info('controller')
        @referral_code = params[:referral_code]
        render_to_string
      end
    end
  end
end
