# frozen_string_literal: true

class AddVideoDurationAndStreamingUrlInTopic < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table :topics, bulk: true do |t|
        t.bigint :video_duration
        t.string :streaming_url
      end
    end
  end
end
