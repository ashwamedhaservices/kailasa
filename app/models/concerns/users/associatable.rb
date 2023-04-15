# frozen_string_literal: true

module Users
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      has_many :referees, class_name: 'User', foreign_key: 'referrer_id'
      belongs_to :referrer, class_name: 'User', optional: true
      has_many :profiles
      has_many :enrollments
    end
  end
end
