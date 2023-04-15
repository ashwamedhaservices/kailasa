# frozen_string_literal: true

class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :enrollments do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.integer :status, limit: 1, default: 0
      t.float :percentage_completion
      t.datetime :video_timestamp
      t.datetime :enrolled_at
      t.datetime :last_active_at

      t.timestamps
    end
  end
end
