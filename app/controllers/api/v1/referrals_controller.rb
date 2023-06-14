# frozen_string_literal: true

module Api
  module V1
    class ReferralsController < ApplicationController
      before_action :authorize_user!, except: %i[index]

      def index
        Rails.logger.info("logs check #{params[:referral_code]}")
      end
    end
  end
end
