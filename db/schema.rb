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

ActiveRecord::Schema[7.0].define(version: 2024_01_19_202710) do
  create_table "addresses", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "status", limit: 1, default: 0
    t.integer "address_type", limit: 1, default: 0
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "address_line_three"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.bigint "kyc_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kyc_id"], name: "index_addresses_on_kyc_id"
  end

  create_table "admin_users", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "status", limit: 1, default: 0
    t.integer "role", limit: 1, default: 0
    t.index ["user_id"], name: "index_admin_users_on_user_id"
  end

  create_table "answers", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "value"
    t.text "explanation"
    t.boolean "correct", default: false, null: false
    t.bigint "question_id", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "bank_accounts", charset: "utf8mb3", force: :cascade do |t|
    t.string "account_number"
    t.integer "status", limit: 1, default: 0
    t.integer "account_type", limit: 1, default: 0
    t.string "ifsc"
    t.string "micr"
    t.string "bank"
    t.string "branch"
    t.string "city"
    t.integer "proof_type", limit: 1, default: 0
    t.string "proof_url"
    t.bigint "kyc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_number"], name: "index_bank_accounts_on_account_number"
    t.index ["kyc_id"], name: "index_bank_accounts_on_kyc_id"
  end

  create_table "chapters", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "description"
    t.string "image_url"
    t.string "photo_url"
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "courses", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "description"
    t.string "image_url"
    t.string "photo_url"
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

  create_table "credits", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "for_user_id"
    t.integer "status", limit: 1, default: 0
    t.integer "credit_type", limit: 1, default: 0
    t.float "amount"
    t.integer "level"
    t.datetime "date"
    t.index ["for_user_id"], name: "index_credits_on_for_user_id"
    t.index ["user_id", "for_user_id", "credit_type"], name: "index_credits_on_user_id_and_for_user_id_and_credit_type"
    t.index ["user_id"], name: "index_credits_on_user_id"
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

  create_table "kycs", charset: "utf8mb3", force: :cascade do |t|
    t.integer "status", limit: 1, default: 0
    t.string "name"
    t.string "id_proof_no"
    t.string "id_proof_url"
    t.integer "id_proof_type", limit: 1
    t.string "address_proof_no"
    t.string "address_proof_url"
    t.integer "address_proof_type", limit: 1
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_kycs_on_user_id"
  end

  create_table "meetings", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "description"
    t.integer "status", limit: 1, default: 0
    t.integer "provider", limit: 1, default: 0
    t.string "id_at_provider"
    t.string "url"
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["start_time", "end_time"], name: "index_meetings_on_start_time_and_end_time"
  end

  create_table "nominees", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "status", limit: 1, default: 0
    t.integer "nominee_type", limit: 1, default: 0
    t.string "dob"
    t.integer "relationship", limit: 1
    t.bigint "kyc_id", null: false
    t.bigint "address_id"
    t.bigint "guardian_id"
    t.integer "relationship_with_guardian", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_nominees_on_address_id"
    t.index ["guardian_id"], name: "index_nominees_on_guardian_id"
    t.index ["kyc_id"], name: "index_nominees_on_kyc_id"
  end

  create_table "payment_gateways", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "status", limit: 1, default: 0
    t.string "partner_id"
    t.string "api_key"
    t.string "secret"
    t.string "success_url"
    t.string "failure_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", charset: "utf8mb3", force: :cascade do |t|
    t.string "uuid"
    t.string "amount"
    t.integer "status", limit: 1, default: 0
    t.integer "mode", limit: 1
    t.integer "platform", limit: 1
    t.integer "for", limit: 1
    t.string "notes"
    t.string "err"
    t.string "errdesc"
    t.string "pg_transaction_no"
    t.string "txn_reference_no"
    t.datetime "settlement_time"
    t.datetime "refund_time"
    t.bigint "user_id", null: false
    t.bigint "subscription_id", null: false
    t.bigint "payment_gateway_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_gateway_id"], name: "index_payments_on_payment_gateway_id"
    t.index ["subscription_id"], name: "index_payments_on_subscription_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "penny_drops", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "name_at_bank"
    t.integer "status", limit: 1, default: 0
    t.string "remarks"
    t.bigint "bank_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_account_id"], name: "index_penny_drops_on_bank_account_id"
  end

  create_table "product_referrals", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_subscription_id", null: false
    t.bigint "user_id", null: false
    t.bigint "referred_user_id", null: false
    t.string "referred_user_name"
    t.string "referred_user_email"
    t.string "referred_user_mobile_number"
    t.index ["product_subscription_id"], name: "index_product_referrals_on_product_subscription_id"
    t.index ["referred_user_id"], name: "index_product_referrals_on_referred_user_id"
    t.index ["user_id"], name: "index_product_referrals_on_user_id"
  end

  create_table "product_subscriptions", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "user_category", limit: 1, default: 0
    t.string "name"
    t.integer "status", limit: 1, default: 0
    t.integer "category", limit: 1, default: 0
    t.float "amount"
    t.integer "referral_count"
    t.index ["user_id"], name: "index_product_subscriptions_on_user_id"
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

  create_table "question_paper_questions", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_number"
    t.bigint "question_paper_id", null: false
    t.bigint "question_id", null: false
    t.index ["question_id"], name: "index_question_paper_questions_on_question_id"
    t.index ["question_paper_id"], name: "index_question_paper_questions_on_question_paper_id"
  end

  create_table "question_papers", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.text "notes"
    t.string "testable_type", null: false
    t.bigint "testable_id", null: false
    t.index ["testable_type", "testable_id"], name: "index_question_papers_on_testable"
  end

  create_table "questions", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "value"
    t.integer "question_type", limit: 1, default: 0
  end

  create_table "subjects", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "description"
    t.string "image_url"
    t.string "photo_url"
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
    t.string "photo_url"
    t.string "video_url"
    t.string "content_url"
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "video_duration"
    t.string "streaming_url"
    t.bigint "author_id"
    t.string "notes_url"
    t.string "assignment_url"
    t.string "notification_url"
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

  add_foreign_key "addresses", "kycs"
  add_foreign_key "admin_users", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "bank_accounts", "kycs"
  add_foreign_key "chapters", "subjects"
  add_foreign_key "credits", "users"
  add_foreign_key "credits", "users", column: "for_user_id"
  add_foreign_key "enrollments", "profiles"
  add_foreign_key "enrollments", "topics"
  add_foreign_key "kycs", "users"
  add_foreign_key "nominees", "addresses"
  add_foreign_key "nominees", "kycs"
  add_foreign_key "nominees", "nominees", column: "guardian_id"
  add_foreign_key "payments", "payment_gateways"
  add_foreign_key "payments", "subscriptions"
  add_foreign_key "payments", "users"
  add_foreign_key "penny_drops", "bank_accounts"
  add_foreign_key "product_referrals", "product_subscriptions"
  add_foreign_key "product_referrals", "users"
  add_foreign_key "product_referrals", "users", column: "referred_user_id"
  add_foreign_key "product_subscriptions", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "question_paper_questions", "question_papers"
  add_foreign_key "question_paper_questions", "questions"
  add_foreign_key "subjects", "courses"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "topics", "chapters"
  add_foreign_key "topics", "users", column: "author_id"
  add_foreign_key "users", "users", column: "referrer_id"
end
