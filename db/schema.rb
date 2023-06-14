# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_13_200020) do
  create_table "chapters", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "description"
    t.string "image_url"
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "courses", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "description"
    t.string "image_url"
    t.integer "status", limit: 1, default: 0
    t.decimal "price", precision: 10
    t.integer "language", limit: 2, default: 0
    t.integer "level", limit: 1, default: 0
    t.float "hours"
    t.integer "topic_count"
    t.bigint "enrolled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "topic_id", null: false
    t.integer "status", limit: 1, default: 0
    t.float "percentage_completion"
    t.bigint "current_timestamp"
    t.datetime "enrolled_at"
    t.datetime "last_active_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id", "topic_id"], name: "index_enrollments_on_profile_id_and_topic_id", unique: true
    t.index ["profile_id"], name: "index_enrollments_on_profile_id"
    t.index ["topic_id"], name: "index_enrollments_on_topic_id"
  end

  create_table "profiles", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "status", limit: 1, default: 0
    t.date "dob"
    t.integer "age", limit: 1
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "subjects", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "description"
    t.string "image_url"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_subjects_on_course_id"
  end

  create_table "subscriptions", charset: "utf8mb3", force: :cascade do |t|
    t.integer "status", limit: 1, default: 0
    t.integer "kind", limit: 1, default: 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "topics", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "description"
    t.string "image_url"
    t.string "video_url"
    t.string "content_url"
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "video_duration"
    t.string "streaming_url"
    t.bigint "author_id"
    t.index ["author_id"], name: "index_topics_on_author_id"
    t.index ["chapter_id"], name: "index_topics_on_chapter_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.string "fname"
    t.string "mname"
    t.string "lname"
    t.integer "iters"
    t.string "salt"
    t.string "password_digest"
    t.string "email"
    t.string "mobile_number", null: false
    t.string "state"
    t.integer "type", limit: 1
    t.string "referral_code"
    t.bigint "referrer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "subscribed", default: false, null: false
    t.index ["mobile_number"], name: "index_users_on_mobile_number", unique: true
    t.index ["referrer_id"], name: "index_users_on_referrer_id"
    t.index ["state"], name: "index_users_on_state"
  end

  create_table "versions", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", size: :long
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "chapters", "subjects"
  add_foreign_key "enrollments", "profiles"
  add_foreign_key "enrollments", "topics"
  add_foreign_key "profiles", "users"
  add_foreign_key "subjects", "courses"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "topics", "chapters"
  add_foreign_key "topics", "users", column: "author_id"
  add_foreign_key "users", "users", column: "referrer_id"
end
