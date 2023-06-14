# frozen_string_literal: true

class AddSubscribedToUser < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table :users, bulk: true do |t|
        t.boolean :subscribed, default: false, null: false
      end
    end
  end
end
