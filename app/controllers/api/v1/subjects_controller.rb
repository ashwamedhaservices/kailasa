# frozen_string_literal: true

module Api
  module V1
    class SubjectsController < ApplicationController
      def index
        @subject = Course.find(params[:course_id]).subjects
        render json: success(data: @subject), status: :ok
      end

      def show
        @subject = Subject.find(params[:id])
        render json: success(data: @subject), status: :ok
      end

      def create
        @course = Course.find(params[:course_id])
        @subject = @course.subjects.new(subject_create_params)
        if @subject.save
          render json: success(data: @subject), status: :ok
        else
          render json: failure(msg: @subject.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      def update
        @subject = Subject.find(params[:id])
        if @subject.update(subject_update_params)
          render json: success(data: @subject), status: :ok
        else
          render json: failure(msg: @subject.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      private

      def subject_create_params
        params.require(:subject).permit(:name, :description, :image_url)
      end

      def subject_update_params
        params.require(:subject).permit(:name, :description, :image_url)
      end
    end
  end
end
