# frozen_string_literal: true

# == Schema Information
#
# Table name: penny_drops
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  name_at_bank    :string(255)
#  status          :integer          default(0)
#  remarks         :string(255)
#  bank_account_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_penny_drops_on_bank_account_id  (bank_account_id)
#
class PennyDrop < ApplicationRecord
  belongs_to :bank_account
end
