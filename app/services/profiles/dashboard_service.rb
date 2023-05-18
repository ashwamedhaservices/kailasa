# frozen_string_literal: true

module Profiles
  # service to generate information visible on profile dashboard
  class DashboardService
    attr_reader :profile

    def initialize(profile)
      @profile = profile
    end

    def call
      return ::ServiceResponse.error(msg: 'empty profile') unless profile

      res = response
      Rails.logger.info("response is #{res}")
      ::ServiceResponse.success(data: res)
    end

    def response
      {
        profile:,
        popular_courses: Course.first(5),
        courses: Course.first(5),
        enrollment: profile.enrollments.order(last_active_at: :desc).first(3)
      }
    end
  end
end
