# frozen_string_literal: true

module Topics
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :chapter
    end
  end
end
