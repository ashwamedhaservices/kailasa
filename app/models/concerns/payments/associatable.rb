# frozen_string_literal: true

module Payments
  module Associatable
    extend ActiveSupport::Concern

    # associations
    included do
      belongs_to :user
      belongs_to :subscription
      belongs_to :payment_gateway
    end
  end
end
