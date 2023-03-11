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

ActiveRecord::Schema[7.0].define(version: 2023_03_11_160247) do
  create_table "referrals", charset: "utf8mb3", force: :cascade do |t|
    t.integer "referrer_id"
    t.integer "referee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", charset: "utf8mb3", force: :cascade do |t|
    t.float "amount"
    t.float "balance"
    t.string "ref_no"
    t.datetime "date"
    t.string "type"
    t.bigint "wallets_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wallets_id"], name: "index_transactions_on_wallets_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.integer "phone", null: false
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_users_on_phone"
  end

  create_table "wallets", charset: "utf8mb3", force: :cascade do |t|
    t.integer "status"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_wallets_on_users_id"
  end

end
