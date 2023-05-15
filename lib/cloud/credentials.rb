# frozen_string_literal: true

module Cloud
  class Credentials
    class << self
      def s3
        {
          access_key_id: Rails.application.credentials.aws.access_key_id,
          secret_access_key: Rails.application.credentials.aws.secret_access_key,
          endpoint: Rails.application.credentials.aws.endpoint,
          region: 'ap-south-1'
        }
      end
    end
  end
end
