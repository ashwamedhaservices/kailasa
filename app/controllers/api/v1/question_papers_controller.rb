# frozen_string_literal: true

module Api
  module V1
    class QuestionPapersController < ApplicationController
      def question_paper_for_testable
        unless testable_question_paper
          return render json: failure(msg: 'question paper not found', error_code: 'record_not_found'),
                        status: :not_found
        end
        render json: success(data: build_question_paper), status: :ok
      end

      private

      def testable_question_paper
        @testable_question_paper ||= QuestionPaper.find_by(
          testable_id: params[:testable_id],
          testable_type: params[:testable_type]&.camelcase
        )&.questions&.includes(:answers)&.order(:question_number)
      end

      def build_question_paper
        response = {}
        question_number = 1
        testable_question_paper.each do |question|
          response[question_number] = question.to_response.merge(answers: [])
          question.answers.each do |answer|
            response[question_number][:answers] << answer.to_response
          end
          question_number += 1
        end
        response
      end
    end
  end
end
