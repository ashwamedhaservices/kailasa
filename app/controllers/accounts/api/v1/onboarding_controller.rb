# frozen_string_literal: true

module Accounts
  module Api
    module V1
      class OnboardingController < ApplicationController
        def index
          json_success(msg: 'Onboarding status', data: Onboarding::Status.call(current_user))
        end
      end
    end
  end
end
