# frozen_string_literal: true

class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.integer :status, limit: 1, default: 0
      t.float :percentage_completion
      t.time :video_timestamp
      t.datetime :enrolled_at
      t.datetime :last_active_at

      t.timestamps
    end
  end
end
