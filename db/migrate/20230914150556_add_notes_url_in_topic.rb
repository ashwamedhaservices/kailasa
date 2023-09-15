# frozen_string_literal: true

class AddNotesUrlInTopic < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :notes_url, :string
  end
end
