# frozen_string_literal: true

module Users
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      has_many :referees, class_name: 'User', foreign_key: 'referrer_id', dependent: :restrict_with_error,
                          inverse_of: :referrer
      belongs_to :referrer, class_name: 'User', optional: true
      has_many :profiles, dependent: :restrict_with_error
      has_many :enrollments, dependent: :restrict_with_error
    end
  end
end
