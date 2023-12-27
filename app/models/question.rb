# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  value         :text(65535)
#  question_type :integer          default("samcq")
#
class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :question_paper_questions, dependent: :destroy
  has_many :question_papers, through: :question_paper_questions

  enum :question_type, %i[samcq mamcq passage one_word]

  def to_response
    { id:, value:, question_type: }
  end
end
