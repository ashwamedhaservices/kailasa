# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      def index
        @course = Course.all
        render json: { status: 'success', data: @course }, status: :ok
      end

      def show
        @course = Course.find(params[:id])
        render json: { status: 'success', data: @course }, status: :ok
      end

      def create
        @course = Course.new(params.require(:course).permit(:name, :description, :image, :price))
        if @course.save
          render json: { status: 'success', data: @course }, status: :ok
        else
          render json: { status: 'failure', message: course.errors.full_messages.to_sentence }, status: :bad_request
        end
      end
    end
  end
end
