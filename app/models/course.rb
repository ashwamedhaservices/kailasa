# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  name        :string(60)
#  description :string(255)
#  image_url   :string(255)
#  photo_url   :string(255)
#  status      :integer          default("created")
#  price       :decimal(10, )
#  language    :integer          default("unspecified")
#  level       :integer          default("primary")
#  hours       :float(24)
#  topic_count :integer
#  enrolled    :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Course < ApplicationRecord
  has_many :subjects, dependent: :restrict_with_error

  enum :status, %i[created published archived]
  enum :level, %i[primary secondary higher_secondary bachelors masters professional life_skill]
  enum :language, %i[unspecified english hindi kannada]
end
