# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      # skip_before_action :authorize_user!

      # POST api/v1/sessions
      def create
        # TODO: social sign on Google, Apple
        # user can login using an identifier from phone or email or referral code
        # Along with OTP or Password
      end

      # POST api/v1/sessions/otp
      def otp
        # trigger OTP on registered phone
      end
    end
  end
end
