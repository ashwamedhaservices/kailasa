# frozen_string_literal: true

module Api
  module V1
    class TopicSerializer < ApplicationSerializer
      attribute :id, :name, :description, :image_url,
                :video_url, :content_url, :chapter_id, :video_duration, :streaming_url
    end
  end
end
