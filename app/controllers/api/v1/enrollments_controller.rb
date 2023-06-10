# frozen_string_literal: true

module Api
  module V1
    class EnrollmentsController < ApplicationController
      def create
        @topic = Topic.find(params[:topic_id])
        create_or_update_profiles_enrollment
        if @enrollment.save
          render json: success(data: @enrollment), status: :ok
        else
          render json: failure(msg: @enrollment.errors.full_messages.to_sentence), status: :bad_request
        end
      end

      private

      def create_params
        params.require(:enrollment).permit(:current_timestamp)
      end

      def create_or_update_profiles_enrollment
        @enrollment = @topic.enrollments.find_or_initialize_by(profile_id: current_profile.id)
        @enrollment.current_timestamp = create_params[:current_timestamp]
        @enrollment.last_active_at = Time.current
        @enrollment.enrolled_at = Time.current if @enrollment.new_record?
        @enrollment.percentage_completion = percentage_completion if change_percentage_completion?
      end

      def change_percentage_completion?
        percentage_completion > @enrollment.percentage_completion.to_i
      end

      def percentage_completion
        @percentage_completion ||= (create_params[:current_timestamp].to_f / @topic.video_duration.to_i) * 100
      end
    end
  end
end
