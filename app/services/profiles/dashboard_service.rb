# frozen_string_literal: true

module Profiles
  # service to generate information visible on profile dashboard
  class DashboardService
    extend Callable
    include Service

    attr_reader :user, :profile

    def initialize(user, profile)
      @user = user
      @profile = profile
    end

    def call
      return error(msg: 'empty profile') unless profile
      return error(msg: 'empty user') unless profile

      res = response
      Rails.logger.info("response is #{res}")
      success(data: res)
    end

    def response
      {
        user: Api::V1::UserSerializer.new(user).serializable_hash.dig(:data, :attributes),
        profile:,
        popular_courses: Course.first(5),
        courses: all_courses_by_level,
        enrollment: profile.enrollments.order(last_active_at: :desc).first(3)
      }
    end

    # TODO: cache it
    def all_courses_by_level
      {}.tap do |r|
        Course.find_each do |c|
          if r[c.level]
            r[c.level] << c
          else
            r[c.level] = [c]
          end
        end
      end
    end
  end
end
