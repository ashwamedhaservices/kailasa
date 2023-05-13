# frozen_string_literal: true

module Api
  module V1
    class FileUploadController < ApplicationController
      def create
        s3_client = Cloud::S3Client.new(Cloud::Credentials.s3)
        url = s3_client.presigned_url(
          'kailasa-bucket1',
          "#{create_params[:location]}/#{create_params[:name]}.#{create_params[:type]}"
        )
        render json: success(msg: url), status: :ok
      end

      private

      def create_params
        @create_params ||= params.require(:file).permit(:name, :location, :type)
      end
    end
  end
end
