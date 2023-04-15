# frozen_string_literal: true

# == Schema Information
#
# Table name: subjects
#
#  id          :bigint           not null, primary key
#  name        :string(60)
#  description :string(255)
#  image_url   :string(255)
#  course_id   :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Subject < ApplicationRecord
  include Subjects::Associatable
end