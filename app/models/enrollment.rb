# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id                    :bigint           not null, primary key
#  profile_id            :bigint           not null
#  topic_id              :bigint           not null
#  status                :integer          default("enrolled")
#  percentage_completion :float(24)
#  current_timestamp     :bigint
#  enrolled_at           :datetime
#  last_active_at        :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_enrollments_on_profile_id               (profile_id)
#  index_enrollments_on_profile_id_and_topic_id  (profile_id,topic_id) UNIQUE
#  index_enrollments_on_topic_id                 (topic_id)
#
class Enrollment < ApplicationRecord
  belongs_to :profile
  belongs_to :topic

  enum :status, %i[enrolled active]
end
