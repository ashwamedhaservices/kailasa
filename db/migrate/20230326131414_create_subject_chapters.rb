# frozen_string_literal: true

class CreateSubjectChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :subject_chapters do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
