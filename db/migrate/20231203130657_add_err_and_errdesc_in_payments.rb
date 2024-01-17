# frozen_string_literal: true

class AddErrAndErrdescInPayments < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table :payments, bulk: true do |t|
        t.string :err, after: :notes
        t.string :errdesc, after: :err
      end
    end
  end
end
