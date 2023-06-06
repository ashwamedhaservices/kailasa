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
        @subject = @course.subjects.new(params.require(:subject).permit(:name, :description, :image_url))
        if @subject.save
          render json: success(data: @subject), status: :ok
        else
          render json: error(msg: @subject.errors.full_messages.to_sentence), status: :bad_request
        end
      end
    end
  end
end
