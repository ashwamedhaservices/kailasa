# frozen_string_literal: true

# == Schema Information
#
# Table name: question_paper_questions
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  question_number   :integer
#  question_paper_id :bigint           not null
#  question_id       :bigint           not null
#
# Indexes
#
#  index_question_paper_questions_on_question_id        (question_id)
#  index_question_paper_questions_on_question_paper_id  (question_paper_id)
#
class QuestionPaperQuestion < ApplicationRecord
  belongs_to :question_paper
  belongs_to :question
end
