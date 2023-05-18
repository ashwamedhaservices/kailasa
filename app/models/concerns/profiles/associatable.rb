# frozen_string_literal: true

module Profiles
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :user
      has_many :enrollments, dependent: :destroy
    end
  end
end
