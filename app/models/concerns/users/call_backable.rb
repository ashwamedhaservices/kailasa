# frozen_string_literal: true

module Users
  module CallBackable
    extend ActiveSupport::Concern

    # callbacks
    included do
      before_save :test
    end

    private

    def test; end
  end
end
