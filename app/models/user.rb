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
# Indexes
#
#  index_users_on_mobile_number  (mobile_number) UNIQUE
#  index_users_on_referrer_id    (referrer_id)
#  index_users_on_state          (state)
#
class User < ApplicationRecord
  self.inheritance_column = nil
  include Users::StateMachine
  include Users::Validatable

  before_create :salt_password

  has_many :referees, class_name: 'User', foreign_key: 'referrer_id', dependent: :restrict_with_error,
                      inverse_of: :referrer
  belongs_to :referrer, class_name: 'User', optional: true
  has_many :profiles, dependent: :restrict_with_error
  has_many :enrollments, dependent: :restrict_with_error
  has_one :subscription, dependent: :restrict_with_error
  has_one :kyc, dependent: :restrict_with_error
  has_many :payments, dependent: :restrict_with_error
  has_many :product_subscriptions, dependent: :destroy
  has_many :product_referrals, dependent: :destroy
  has_many :credits, dependent: :destroy

  enum :type, %i[customer admin super_admin author student]

  scope :subscribed, -> { where(subscribed: true) }

  def subscribed! =  update(subscribed: true)
  def subscribed? = subscribed.eql? true

  def full_name
    name = [fname, mname, lname].reject(&:empty?).join(' ')
    name.blank? ? 'Guest' : "#{title} #{name}".titlecase
  end

  # TODO: temp action
  def token(profile_id = profiles.first.id)
    # ::Kailasa::Jwt.encode({ id: id, profile_id: profiles.first.id, exp: 1.day.from_now.to_i })
    ::Kailasa::Jwt.encode({ id:, profile_id: })
  end

  def authenticate(password)
    password_digest.eql? ::Utils::Password.encrypt(password:, salt:)
  end

  def salt_password
    self.salt = SecureRandom.hex(8)
    self.iters = 1000
    self.password_digest = ::Utils::Password.encrypt(password: password_digest, salt:, iters:)
  end

  def referral_url
    "https://ashwamedhaservices.com/register?referral_code=#{referral_code}"
  end

  # deperecated from here
  def earnings
    {
      balance:,
      processing:,
      withdrawn:,
      credited_points:,
      withdrawable_amount:,
      withdrawn_points:,
      remaining_amount:,
      remaining_points:
    }
  end

  def balance
    @balance ||= ReferralCredit.where(user_id: id, status: 'credited').sum(:amount)
  end

  def processing
    ReferralCredit.where(user_id: id, status: 'processed').sum(:amount)
  end

  def withdrawn
    ReferralCredit.where(user_id: id, status: 'paid').sum(:amount)
  end

  def credited_points
    @credited_points ||= (withdrawable_amount / 1.5).round(2)
  end

  def withdrawable_amount
    @withdrawable_amount ||= ReferralCredit.where(user_id: id, status: 'credited').sum(:amount)
  end

  def withdrawn_points
    @withdrawn_points ||= (withdrawn_amount / 1.5).round(2)
  end

  def withdrawn_amount
    @withdrawn_amount ||= ReferralCredit.where(user_id: id, status: 'paid').sum(:amount)
  end

  def remaining_amount
    @remaining_amount ||= withdrawable_amount - withdrawn_amount
  end

  def remaining_points
    # @remaining_points ||= credited_points - withdrawn_points
    @remaining_points ||= withdrawable_amount - withdrawn_amount
  end
  # till here
end
