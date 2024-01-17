# frozen_string_literal: true

class AddPartnerIdInPaymentGateway < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_gateways, :partner_id, :string, after: :status
  end
end
