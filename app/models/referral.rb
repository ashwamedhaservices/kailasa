class Referral < ApplicationRecord
  belongs_to :referrer, class_name: "User", foreign_key: "referrer_id"
  belongs_to :referee, class_name: "User", foreign_key: "referee_id"
  # has_many :transactions as: :transactable
  # accepts_nested_attributes_for :referrer, :referee
  
  enum :plan, { one_month: 0, three_month: 1, six_month: 2, one_year: 3, other: 4 }
end
