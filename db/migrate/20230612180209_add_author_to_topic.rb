# frozen_string_literal: true

class AddAuthorToTopic < ActiveRecord::Migration[7.0]
  def change
    add_reference :topics, :author, foreign_key: { to_table: :users }
  end
end
