# frozen_string_literal: true

module Courses
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      has_many :subjects
      has_many :enrollments
    end
  end
end
