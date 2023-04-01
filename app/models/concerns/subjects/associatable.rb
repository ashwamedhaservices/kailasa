# frozen_string_literal: true

module Subjects
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :course
      has_many :chapters
    end
  end
end
