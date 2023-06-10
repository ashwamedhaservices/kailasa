# frozen_string_literal: true

module Topics
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :chapter
      has_many :enrollments, dependent: :restrict_with_error
    end
  end
end
