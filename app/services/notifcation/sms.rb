# frozen_string_literal: true

module ::Notifcation
  class Sms
    def trigger
      ::Sms::Client.trigger(options)
    end

    private

    def options; end
  end
end
