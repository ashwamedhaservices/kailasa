# frozen_string_literal: true

module Payments
  class Configs
    class << self
      def json
        {
          gateway: 'hdfc'
        }
      end
    end
  end
end
