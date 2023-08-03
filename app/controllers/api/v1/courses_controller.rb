# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      def index
        @course = Course.all.to_a.reject { |c| c.name.match(/ to /) }
        render json: success(data: @course), status: :ok
      end

      def show
        @course = Course.find(params[:id])
        render json: success(data: @course), status: :ok
      end

      def create
        @course = Course.new(course_create_params)
        if @course.save
          render json: success(data: @course), status: :ok
        else
          render json: failure(msg: @course.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      def update
        @course = Course.find(params[:id])
        if @course.update(course_update_params)
          render json: success(data: @course), status: :ok
        else
          render json: failure(msg: @course.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      def bundle
        @course = Course.where("name like '%to%'")
        render json: success(data: @course), status: :ok
      end

      private

      def course_create_params
        params.require(:course).permit(:name, :description, :image_url, :price, :language, :level, :hours)
      end

      def course_update_params
        params.require(:course).permit(:name, :description, :image_url, :price, :language, :level, :hours)
      end
    end
  end
end
