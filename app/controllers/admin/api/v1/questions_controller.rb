# frozen_string_literal: true

module Admin
  module Api
    module V1
      class QuestionsController < ApplicationController
        def index
          return question_not_found unless question

          json_success(data: question)
        end

        def show
          return question_not_found unless question

          res = question.to_response.merge(answers: [])
          question.answers.each do |answer|
            res[:answers] << answer.to_respons
          end
          json_success(data: res)
        end

        def create
          if question.save
            json_created(msg: 'question created successfully', data: question)
          else
            json_failure(msg: question.errors.full_messages.to_sentence)
          end
        end

        def update
          return question_not_found unless question

          if question.update(question_update_params)
            json_success(msg: 'question updated successfully', data: question)
          else
            json_failure(msg: question.errors.full_messages.to_sentence)
          end
        end

        def add_answer
          return question_not_found unless question

          add_answer_params.each do |add_answer_param|
            unless question.answers.create(add_answer_param)
              json_failure(msg: question.errors.full_messages.to_sentence)
            end
          end
          json_success(msg: 'answers added successfully', data: { question:, answers: question.answers })
        end

        private

        def question
          @question ||= params[:id].present? ? Question.find_by(id: params[:id]) : Question.new(question_create_params)
        end

        def question_create_params
          params.require(:question).permit(:value, :question_type)
        end

        def question_update_params
          params.require(:question).permit(:value, :question_type)
        end

        def add_answer_params
          params.require(:answers).permit(
            answers: %i[value correct explanation]
          )
        end

        def question_not_found
          json_success(msg: 'question doesnot exists', error_code: 'record_not_found')
        end
      end
    end
  end
end
