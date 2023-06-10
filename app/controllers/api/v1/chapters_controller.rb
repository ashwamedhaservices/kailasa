# frozen_string_literal: true

module Api
  module V1
    class ChaptersController < ApplicationController
      def index
        @chapter = Subject.find(params[:subject_id]).chapters
        render json: success(data: @chapter), status: :ok
      end

      def show
        @chapter = Chapter.find(params[:id])
        render json: success(data: @chapter), status: :ok
      end

      def create
        @subject = Subject.find(params[:subject_id])
        @chapter = @subject.chapters.new(chapter_create_params)
        if @chapter.save
          render json: success(data: @chapter), status: :ok
        else
          render json: failure(msg: @chapter.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      def update
        @chapter = Chapter.find(params[:id])
        if @chapter.update(chapter_update_params)
          render json: success(data: @chapter), status: :ok
        else
          render json: failure(msg: @chapter.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      private

      def chapter_create_params
        params.require(:chapter).permit(:name, :description, :image_url)
      end

      def chapter_update_params
        params.require(:chapter).permit(:name, :description, :image_url)
      end
    end
  end
end
