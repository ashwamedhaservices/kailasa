# frozen_string_literal: true

module Profiles
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :user
      has_many :enrollments, dependent: :restrict_with_error
    end
  end
end
