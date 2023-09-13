# frozen_string_literal: true

module Admin
  module Api
    module V1
      class QuestionPapersController < ApplicationController
        def show
          return question_paper_not_found unless question_paper

          json_success(data: question_paper.questions_with_answers)
        end

        def create
          return testable_not_found unless testable

          question_paper = testable.question_papers.create!(name: question_paper_create_params[:name],
                                                            notes: question_paper_create_params[:notes])
          json_success(data: question_paper)
        end

        def question
          return question_paper_not_found unless question_paper

          question_and_answer = create_question_and_answers
          question_paper.add_question(question_params[:question_no], question_and_answer[:question])
          json_success(msg: 'question added successfully')
        rescue StandardError => e
          Rails.logger.error("error in adding question to question paper: #{e.message}")
          json_failure(msg: e.message, error_code: 'standard_error')
        end

        private

        def question_paper
          @question_paper ||= QuestionPaper.find(params[:id])
        end

        def question_params
          params.require(:question_paper).permit(
            :question,
            :question_no,
            :type,
            answers: %i[value explanation correct]
          )
        end

        def question_paper_create_params
          params.require(:question_paper).permit(:name, :notes, :testable_type, :testable_id)
        end

        def testable
          @testable ||= question_paper_create_params[:testable_type]
                        .to_s.camelcase.constantize.find(question_paper_create_params[:testable_id].to_i)
        end

        def question_paper_not_found
          json_success(msg: 'question paper does not exists', error_code: 'record_not_found')
        end

        def testable_not_found
          json_success(msg: 'testable does not exists', error_code: 'record_not_found')
        end

        def create_question_and_answers
          question = Question.create!(value: question_params[:question], question_type: question_params[:type])
          answers = []
          question_params[:answers].each do |answer|
            answers << question.answers.create!(
              value: answer[:value],
              explanation: answer[:explanation],
              correct: answer[:correct]
            )
          end
          { question:, answers: }
        end
      end
    end
  end
end
