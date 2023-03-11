class Referral < ApplicationRecord
  belongs_to :referrer, class_name: "User", foreign_key: "referrer_id"
  belongs_to :referee, class_name: "User", foreign_key: "referee_id"
  # has_many :transactions as: :transactable
end
