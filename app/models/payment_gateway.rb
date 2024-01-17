# frozen_string_literal: true

# == Schema Information
#
# Table name: payment_gateways
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  status      :integer          default("created")
#  partner_id  :string(255)
#  api_key     :string(255)
#  secret      :string(255)
#  success_url :string(255)
#  failure_url :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PaymentGateway < ApplicationRecord
  enum :status, %i[created active deactivated]

  def api_key
    SymmetricEncryption.decrypt self[:api_key]
  end

  def api_key=(api_key)
    self[:api_key] = SymmetricEncryption.encrypt api_key
  end

  def secret
    SymmetricEncryption.decrypt self[:secret]
  end

  def secret=(secret)
    self[:secret] = SymmetricEncryption.encrypt secret
  end
end
