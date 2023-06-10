# frozen_string_literal: true

module Courses
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      has_many :subjects, dependent: :restrict_with_error
      has_many :enrollments, dependent: :restrict_with_error
    end
  end
end
