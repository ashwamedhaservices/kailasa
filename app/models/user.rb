class User < ApplicationRecord
  has_many :referrals
  has_many :referees, through: :referrals
  has_one :referrer, through: :referrals

  has_one :wallet
end
