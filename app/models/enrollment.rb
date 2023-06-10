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
class Enrollment < ApplicationRecord
  include Enrollments::Associatable

  enum :status, %i[enrolled active]
end
