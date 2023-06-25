# frozen_string_literal: true

# == Schema Information
#
# Table name: payment_gateways
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  status      :integer          default("created")
#  api_key     :string(255)
#  secret      :string(255)
#  success_url :string(255)
#  failure_url :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class PaymentGatewayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
