# frozen_string_literal: true

module Sms
  class Client < Base
    def self.trigger(options)
      new.client.call(options)
    end
  end
end
