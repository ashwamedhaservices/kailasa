# frozen_string_literal: true

class CreateQuestionPaperQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :question_paper_questions do |t|
      t.timestamps

      t.integer :question_number
      t.references :question_paper, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
    end
  end
end
