# frozen_string_literal: true

module Api
  module V1
    class TopicController < ApplicationController
      def index
        @topic = Chapter.find(params[:chapter_id]).chapters
        render json: { status: 'success', data: @chapter }, status: :ok
      end

      def show
        @topic = Topic.find(params[:id])
        render json: { status: 'success', data: @chapter }, status: :ok
      end

      def create
        @chapter = Chapter.find(params[:chapter_id])
        @topic = chapter.topics.new(
          params.require(:topic).permit(:name, :description, :image_url, :video_url, :content_url)
        )
        if @topic.save
          render json: { status: 'success', data: @topic }, status: :ok
        else
          render json: { status: 'failure', message: @topic.errors.full_messages.to_sentence }, status: :bad_request
        end
      end
    end
  end
end
