# frozen_string_literal: true

module Sms
  module Sender
    class Msg91
      extend Callable
      include Service

      attr_reader :options, :resp

      # @param
      # {
      #   mobile: '9901541166',
      #   template_id: '648d6aedd6fc0533786dbbd2',
      #   params: {"otp"=>"156156"}
      # }
      # @return {:code=>200, :body=>{"message"=>"3366716f6a74363639393930", "type"=>"success"}}

      # @example
      # Sms::Sender::Msg91.call(options)
      # => {:code=>200, :body=>{"message"=>"3366716f6c78383232383331", "type"=>"success"}}

      def initialize(options)
        @options = options
      end

      private_class_method :new

      def call
        base_url = credentials[:base_url]
        path = credentials[:path]
        RestRequestHandler.new(base_url).post(path, body, headers)
      end

      def headers
        {
          'accept' => 'application/json',
          'content-type' => 'application/json',
          'authkey' => credentials[:authkey]
        }
      end

      # @return
      # {"template_id"=>"648d6aedd6fc0533786dbbd2", "sender"=>"ASMDHA", "mobiles"=>"919901541166", "otp"=>"121212"}
      def body
        { 'template_id' => dlt_id,
          'sender' => credentials[:sender],
          'mobiles' => "91#{options[:mobile]}" }.merge(options[:params])
      end

      def credentials
        @credentials ||= Rails.application.credentials.msg91
      end

      def dlt_id
        dlt_type = options[:template_type]
        credentials[:dlt][dlt_type]
      end
    end
  end
end
