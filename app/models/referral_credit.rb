# frozen_string_literal: true

class ReferralCredit
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  module ReferralType
    PARTNER = 'partner'
    USER    = 'user'
  end

  field :amount,                        type: Float
  field :level,                         type: String  # credit level
  field :user_id,                       type: Integer # credited to user
  field :type,                          type: String  # credit type - direct or mlm
  field :subscribed_user_id,            type: Integer
  field :date,                          type: DateTime

  index({ user_id: 1 }, background: true)
  index({ subscribed_user_id: 1 }, background: true)
  index({ level: 1 }, background: true)
  index({ date: 1 }, background: true)
end
