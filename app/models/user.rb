# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  title           :string(255)
#  fname           :string(255)
#  mname           :string(255)
#  lname           :string(255)
#  iters           :integer
#  salt            :string(255)
#  password_digest :string(255)
#  email           :string(255)
#  mobile_number   :string(255)      not null
#  state           :string(255)
#  type            :integer
#  referral_code   :string(255)
#  referrer_id     :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  subscribed      :boolean          default(FALSE), not null
#
class User < ApplicationRecord
  self.inheritance_column = nil
  include Users::StateMachine
  include Users::Associatable
  include Users::Validatable
  include Users::CallBackable

  enum :type, %i[customer admin super_admin author student]

  def full_name
    name = "#{fname} #{mname} #{lname}"
    name.blank? ? 'Guest' : "#{title} #{name}".titlecase
  end

  # TODO: temp action
  def token(profile_id = profiles.first.id)
    # ::Kailasa::Jwt.encode({ id: id, profile_id: profiles.first.id, exp: 1.day.from_now.to_i })
    ::Kailasa::Jwt.encode({ id:, profile_id:, exp: 1.day.from_now.to_i })
  end

  def authenticate(password)
    password_digest.eql? ::Utils::Password.encrypt(password:, salt:)
  end

  def referral_url
    "https://www.ashwamedha.net/register?referral_code=#{referral_code}"
  end
end
