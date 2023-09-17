# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  name           :string(255)
#  description    :string(255)
#  status         :integer          default("created")
#  provider       :integer          default("jitsi")
#  id_at_provider :string(255)
#  url            :string(255)
#  start_time     :datetime
#  end_time       :datetime
#
# Indexes
#
#  index_meetings_on_start_time_and_end_time  (start_time,end_time)
#
require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
