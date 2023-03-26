# frozen_string_literal: true

module Sms
  class Base
    attr_reader :client

    def initialize
      @client = sms_active_client
    end

    private

    def sms_active_client
      # to pick from configs
      Sms::Sender::Msg91.instance
    end
  end
end
