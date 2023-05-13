# frozen_string_literal: true

module Api
  module V1
    class ChaptersController < ApplicationController
      def index
        @chapter = Subject.find(params[:subject_id]).chapters
        render json: { status: 'success', data: @chapter }, status: :ok
      end

      def show
        @chapter = Chapter.find(params[:id])
        render json: { status: 'success', data: @chapter }, status: :ok
      end

      def create
        @subject = Subject.find(params[:subject_id])
        @chapter = subject.chapters.new(params.require(:chapter).permit(:name, :description, :image_url))
        if @chapter.save
          render json: { status: 'success', data: @chapter }, status: :ok
        else
          render json: { status: 'failure', message: @chapter.errors.full_messages.to_sentence }, status: :bad_request
        end
      end
    end
  end
end
