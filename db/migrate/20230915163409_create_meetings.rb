# frozen_string_literal: true

class CreateMeetings < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :meetings do |t|
      t.timestamps
      t.string :name
      t.string :description
      t.integer :status, limit: 1, default: 0
      t.integer :provider, limit: 1, default: 0
      t.string :id_at_provider
      t.string :url
      t.datetime :start_time
      t.datetime :end_time
    end
    add_index :meetings, %i[start_time end_time]
  end
end
