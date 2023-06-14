# frozen_string_literal: true

module Subscriptions
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :user
    end
  end
end
