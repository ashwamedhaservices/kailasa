# frozen_string_literal: true

module Subscriptions
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :user
      has_many :payments, dependent: :restrict_with_error
    end
  end
end
