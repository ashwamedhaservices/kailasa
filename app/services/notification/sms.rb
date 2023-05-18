# frozen_string_literal: true

module ::Notification
  class Sms
    def trigger
      ::Sms::Client.trigger(options)
    end

    private

    def options; end
  end
end
