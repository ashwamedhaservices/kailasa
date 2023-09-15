# frozen_string_literal: true

module Api
  module V1
    class TopicsController < ApplicationController
      def index
        @topics = Chapter.find(params[:chapter_id]).topics
        render json: success(data: @topics), status: :ok
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

      def update
        @topic = Topic.find(params[:id])
        if @topic.update(topic_update_params)
          render json: success(data: @topic), status: :ok
        else
          render json: failure(msg: @topic.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      def question_paper
        return topic_not_found unless topic

        json_success(data: topic.question_paper)
      end

      private

      def topic
        @topic ||= Topic.find(params[:id])
      end

      def generate_topic
        @topic = @chapter.topics.new(topic_create_params)
        @topic.author_id = current_user.id
        @topic.streaming_url = topic_create_params[:video_url].split('.').insert(2, 'cdn').join('.')
      end

      def topic_create_params
        @topic_create_params ||= params
                                 .require(:topic)
                                 .permit(:name, :description, :image_url, :video_url, :content_url, :video_duration)
      end

      def topic_update_params
        params.require(:topic).permit(:name, :description, :image_url, :video_url, :content_url, :video_duration)
      end

      def topic_not_found
        json_failure(msg: 'Topic not found', error_code: 'record_not_found')
      end
    end
  end
end
