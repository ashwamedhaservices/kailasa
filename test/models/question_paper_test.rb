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
require 'test_helper'

class QuestionPaperTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
