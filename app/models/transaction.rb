class Transaction < ApplicationRecord
  belongs_to :wallet
  # belongs_to :transactable, polymorphic: true
end
