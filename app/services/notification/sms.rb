# frozen_string_literal: true

module Notification
  class Sms
    def self.trigger(options)
      ::Sms::Client.trigger(options)
    end
  end
end
