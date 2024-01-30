# frozen_string_literal: true

class CreateAccessInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :access_infos do |t|
      t.timestamps
      t.string :session_id
      t.references :user, null: false, foreign_key: true
      t.integer :device, limit: 1, default: 0
      t.integer :platform, limit: 1, default: 0
      t.string :ip_address
      t.string :user_agent
    end
  end
end
