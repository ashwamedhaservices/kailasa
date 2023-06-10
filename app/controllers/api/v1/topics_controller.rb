# frozen_string_literal: true

module Api
  module V1
    class TopicsController < ApplicationController
      def index
        @topic = Chapter.find(params[:chapter_id]).topics
        render json: success(data: @topic), status: :ok
      end

      def show
        @topic = Topic.find(params[:id])
        render json: success(data: @topic), status: :ok
      end

      def create
        @chapter = Chapter.find(params[:chapter_id])
        generate_topic
        if @topic.save
          render json: success(data: @topic), status: :ok
        else
          render json: failure(msg: @topic.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      private

      def generate_topic
        @topic = @chapter.topics.new(topic_create_params)
        @topic.streaming_url = topic_create_params[:video_url].split('.').insert(2, 'cdn').join('.')
      end

      def topic_create_params
        @topic_create_params ||= params
                                 .require(:topic)
                                 .permit(:name, :description, :image_url, :video_url, :content_url, :video_duration)
      end
    end
  end
end
