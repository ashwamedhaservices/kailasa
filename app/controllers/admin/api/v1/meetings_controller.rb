# frozen_string_literal: true

module Admin
  module Api
    module V1
      class MeetingsController < ApplicationController
        def index
          json_success(msg: 'The available meetings are', data: available_meetings)
        end

        def create
          meeting = Meeting.new(meetings_create_params)
          meeting.id_at_provider = meeting.jitsi_id_at_provider(meetings_create_params[:url])
          return json_failure(msg: meeting.errors.full_messages.to_sentence) unless meeting.save

          json_success(msg: 'The meeting was created successfully', data: meeting)
        end

        private

        def available_meetings
          @available_meetings ||= Meeting.where('start_time < ? and end_time > ?', current_time, current_time)
        end

        def current_time
          @current_time ||= DateTime.current
        end

        def meetings_create_params
          params.require(:meetings).permit(:name, :description, :url, :provider, :id_at_provider, :start_time,
                                           :end_time)
        end
      end
    end
  end
end
