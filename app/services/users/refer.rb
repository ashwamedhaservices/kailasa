# frozen_string_literal: true

module Users
  class Refer
    extend Callable
    include Service

    attr_reader :referral_code

    DEFAULT_REFER = %w[00001 00002 00003].freeze # Rails.application.credentials.referral.default_refers

    def initialize(referral_code)
      @referral_code = referral_code
    end

    def call
      refer
    end

    private

    def refer
      return DEFAULT_REFER.sample unless referral_code
      return referring_user.id if referring_user

      nil
    end

    def default_refer
      DEFAULT_REFER.sample
    end

    def referring_user
      @referring_user ||= User.find_by(referral_code:)
    end
  end
end
