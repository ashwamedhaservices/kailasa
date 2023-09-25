# frozen_string_literal: true

module Admin
  module Api
    module V1
      class AnswersController < ApplicationController
        def index
          json_success(data: answers)
        end

        def show
          return answer_not_found unless answer

          json_success(data: answer)
        end

        def create
          if answer.save
            json_created(msg: 'answer created successfully', data: answer)
          else
            json_failure(msg: answer.errors.full_messages.to_sentence)
          end
        end

        def update
          return answer_not_found unless answer

          if answer.update(answer_update_params)
            json_success(msg: 'answer updated successfully', data: answer)
          else
            json_failure(msg: answer.errors.full_messages.to_sentence)
          end
        end

        private

        def answers
          @answers ||= Question.find_by(id: params[:question_id])&.answers
        end

        def answer
          @answer ||= if params[:id].present?
                        Answer.find_by(id: params[:id])
                      else
                        Answer.new(answer_create_params.merge(question_id: params[:question_id]))
                      end
        end

        def answer_create_params
          params.require(:answer).permit(:value, :explanation, :correct)
        end

        def answer_update_params
          params.require(:answer).permit(:value, :explanation, :correct)
        end

        def answer_not_found
          json_success(msg: 'answer doesnot exists', error_code: 'record_not_found')
        end
      end
    end
  end
end
