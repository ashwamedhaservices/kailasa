# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  fname         :string(255)
#  mname         :string(255)
#  lname         :string(255)
#  password      :string(255)
#  email         :string(255)
#  mobile_number :string(255)      not null
#  type          :string(255)
#  referral_code :string(255)
#  referred_by   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  include Users::StateMachine
  include Users::Associatable
  include Users::Validatable

  def full_name
    name = "#{fname} #{mname} #{lname}"
    name.blank? ? 'Guest' : "#{title} #{name}".titlecase
  end

  # TODO: temp action
  def token
    ::Kailasa::Jwt.encode({id: id, exp: 1.day.from_now.to_i})
  end
end
