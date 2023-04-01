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

      ::ServiceResponse.success(data: response)
    end

    def response
      {
        profile: profile,
        popular_courses: Course.first(5),
        courses: Course.first(5),
        enrollment: profile.enrollments.order(last_active_at: :desc).limit(3)
      }
    end
  end
end
