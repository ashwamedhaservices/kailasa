module Aws
  class S3Client
    def initialize(bucket_name:, access_key_id:, secret_access_key:, region: 'ap-south-1')
      @s3 = Aws::S3::Resource.new(
        credentials: Aws::Credentials.new(access_key_id, secret_access_key),
        region: region
      )
      @bucket = @s3.bucket(bucket_name)
    end

    def upload_file(local_file_path, s3_object_key)
      obj = @bucket.object(s3_object_key)
      obj.upload_file(local_file_path)
    end

    def delete_object(s3_object_key)
      obj = @bucket.object(s3_object_key)
      obj.delete
    end
  end
end
