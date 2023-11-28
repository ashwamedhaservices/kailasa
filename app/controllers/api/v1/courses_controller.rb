# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      def index
        @course = courses_in_order
        @course = @course.reject { |c| c.name.match(/ to /) } unless current_user.type.eql?('admin')
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

      def courses_in_order
        course_order.map { |id| course_hash[id] }
      end

      def course_order
        @course_order ||= if current_user.admin?
                            Course.pluck(:id)
                          else
                            [36, 56, 37, 38, 61, 62, 63, 42, 43, 45, 46, 49, 54, 55, 60, 64, 59, 73, 74, 75, 76, 77,
                             78, 79, 80]
                          end
      end

      def course_hash
        @course_hash ||= generate_course_hash
      end

      def generate_course_hash
        course_hash = {}
        Course.all.to_a.each do |course|
          course_hash[course.id] = course
        end
        course_hash
      end
    end
  end
end
