# frozen_string_literal: true

# == Schema Information
#
# Table name: question_papers
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string(255)      not null
#  notes         :text(65535)
#  testable_type :string(255)      not null
#  testable_id   :bigint           not null
#
# Indexes
#
#  index_question_papers_on_testable  (testable_type,testable_id)
#
class QuestionPaper < ApplicationRecord
  has_many :question_paper_questions, dependent: :destroy
  has_many :questions, through: :question_paper_questions
  belongs_to :testable, polymorphic: true

  def to_response
    { name:, notes: }
  end

  def questions_with_answers
    response = {}
    question_number = 1
    questions&.includes(:answers)&.order(:question_number)&.each do |question|
      response[question_number] = question.to_response.merge(answers: [])
      question.answers.each do |answer|
        response[question_number][:answers] << answer.to_response
      end
      question_number += 1
    end
    response
  end

  def add_question(question_no, question)
    question_paper_questions.create!(question_number: question_no, question:)
  end

  def del_question(id)
    question_paper_questions.find_by(question_id: id)&.destroy
  end
end
