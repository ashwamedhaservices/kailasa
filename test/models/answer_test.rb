# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  correct     :boolean          default(FALSE), not null
#  value       :text(65535)
#  explanation :text(65535)
#  question_id :bigint           not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
