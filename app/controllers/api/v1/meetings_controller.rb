# frozen_string_literal: true

module Api
  module V1
    class MeetingsController < ApplicationController
      def index
        json_success(msg: 'The available meetings are', data: available_meetings)
      end

      private

      def available_meetings
        @available_meetings ||= Meeting.where('start_time < ? and end_time > ?', current_time, current_time)
      end

      def current_time
        @current_time ||= DateTime.current
      end
    end
  end
end
