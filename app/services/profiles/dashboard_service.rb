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
        enrollment: profile.enrollments.order(last_active_at: :desc).first(3),
        life_skills: Course.life_skill
      }
    end

    # TODO: cache it
    def all_courses_by_level # rubocop:disable Metrics/MethodLength
      {}.tap do |r|
        Course.find_each do |c|
          level = c.level.to_s.gsub('_', ' ')
          c.level = level
          if r[level]
            r[level] << c
          else
            r[level] = [c]
          end
        end
      end
    end
  end
end
