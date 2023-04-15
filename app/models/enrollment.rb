# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id                    :bigint           not null, primary key
#  profile_id            :bigint           not null
#  course_id             :bigint           not null
#  topic_id              :bigint           not null
#  status                :integer          default(0)
#  percentage_completion :float(24)
#  video_timestamp       :datetime
#  enrolled_at           :datetime
#  last_active_at        :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Enrollment < ApplicationRecord
  include Enrollments::Associatable
end
