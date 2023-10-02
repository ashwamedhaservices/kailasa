# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  value         :string(255)
#  question_type :integer          default("samcq")
#
require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
