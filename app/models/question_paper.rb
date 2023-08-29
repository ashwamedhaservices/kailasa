# frozen_string_literal: true

# == Schema Information
#
# Table name: question_papers
#
#  id            :bigint           not null, primary key
#  name          :string(255)      not null
#  testable_type :string(255)      not null
#  testable_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_question_papers_on_testable  (testable_type,testable_id)
#
class QuestionPaper < ApplicationRecord
  has_many :question_paper_questions, dependent: :destroy
  has_many :questions, through: :question_paper_questions
end
