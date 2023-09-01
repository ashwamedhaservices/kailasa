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
end
