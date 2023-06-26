# frozen_string_literal: true

module Sms
  class Base
    attr_reader :client

    def initialize
      @client = sms_active_client
    end

    private

    def sms_active_client
      Sms::Sender::Msg91
    end
  end
end
