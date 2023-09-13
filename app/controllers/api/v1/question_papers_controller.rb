# frozen_string_literal: true

module Api
  module V1
    class QuestionPapersController < ApplicationController
      def question_paper_for_testable
        unless testable_question_paper
          return render json: failure(msg: 'question paper not found', error_code: 'record_not_found'),
                        status: :not_found
        end
        render json: success(data: testable_question_paper.questions_with_answers), status: :ok
      end

      private

      def testable_question_paper
        @testable_question_paper ||= QuestionPaper.find_by(
          testable_id: params[:testable_id],
          testable_type: params[:testable_type]&.camelcase
        )
      end
    end
  end
end
