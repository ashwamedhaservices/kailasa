# frozen_string_literal: true

module Chapters
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :subject
      has_many :topics, dependent: :destroy
    end
  end
end
