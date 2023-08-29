# frozen_string_literal: true

# == Schema Information
#
# Table name: question_sets
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  name              :string(255)      not null
#  questionable_type :string(255)      not null
#  questionable_id   :bigint           not null
#
# Indexes
#
#  index_question_sets_on_questionable  (questionable_type,questionable_id)
#
class QuestionSet < ApplicationRecord
end
