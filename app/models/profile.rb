# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  dob        :date
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Profile < ApplicationRecord
end
