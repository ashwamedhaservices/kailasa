# frozen_string_literal: true

class AddAssignmentsAndNotificationUrlInTopic < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table(:topics, bulk: true) do |t|
        t.column :assignment_url, :string
        t.column :notification_url, :string
      end
    end
  end
end
