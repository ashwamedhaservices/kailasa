# frozen_string_literal: true

module Courses
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      has_many :subjects, dependent: :destroy
      has_many :enrollments, dependent: :destroy
    end
  end
end
