# frozen_string_literal: true

module Cloud
  class S3Client
    attr_reader :s3

    def initialize(credentails)
      @s3 = Aws::S3::Client.new(
        access_key_id: credentails[:access_key_id],
        secret_access_key: credentails[:secret_access_key],
        force_path_style: true,
        endpoint: credentails[:endpoint],
        region: credentails[:region]
      )
    end

    def upload_file(bucket, file_body, s3_object_key)
      s3.put_object({
                      bucket:,
                      key: s3_object_key,
                      body: file_body,
                      acl: 'private'
                    })
    end

    def presigned_url(bucket, s3_object_key, expiration = nil)
      signer = Aws::S3::Presigner.new(client: s3)
      signer.presigned_url(
        :put_object,
        bucket:,
        key: s3_object_key,
        expires_in: expiration,
        whitelist_headers: ['x-amz-acl': 'public-read']
      )
    end
  end
end
