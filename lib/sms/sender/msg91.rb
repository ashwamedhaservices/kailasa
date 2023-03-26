module Sms
  module Sender
    class Msg91
      include Singleton
      attr_reader :options, :resp

      # options structure
      # {
      #   mobile: sms_params[:sender],
      #   message: sms_params[:message],
      #   template_id: sms_params[:template_id]
      # }
      def call(options)
        puts options
        # TODO
        # @resp = RestHandler.get(url, payload)
      rescue StandardError => e
        # logger
        # sentry
      end

      def payload
        {
          'mobiles' => options[:mobile],
          'authkey' => credentials[:key],
          'DLT_TE_ID' => options[:template_id],
          'route' => credentials[:code],
          'sender' => credentials[:sender],
          'message' => options[:message],
          'country' => '91'
        }
      end

      def url
        credentials[:url]
      end
    end
  end
end
