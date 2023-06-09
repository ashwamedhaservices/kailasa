# frozen_string_literal: true

module Enrollments
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :profile
      belongs_to :topic
    end
  end
end
