# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  value         :string(255)
#  question_type :integer          default("mcq")
#
class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :question_paper_questions, dependent: :destroy
  has_many :question_papers, through: :question_paper_questions

  enum :question_type, %i[mcq passage one_word]
end
