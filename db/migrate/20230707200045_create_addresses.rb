# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :addresses do |t|
      t.string :name
      t.integer :status, limit: 1, default: 0
      t.integer :type, limit: 1, default: 0
      t.string :address_line_one
      t.string :address_line_two
      t.string :address_line_three
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.references :kycs, null: false, foreign_key: true
      t.timestamps
    end
  end
end
