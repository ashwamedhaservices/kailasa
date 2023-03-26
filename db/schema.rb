# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_326_131_414) do
  create_table 'chapters', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.string 'image_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'course_subjects', charset: 'utf8mb3', force: :cascade do |t|
    t.bigint 'course_id', null: false
    t.bigint 'subject_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['course_id'], name: 'index_course_subjects_on_course_id'
    t.index ['subject_id'], name: 'index_course_subjects_on_subject_id'
  end

  create_table 'courses', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.string 'image_url'
    t.decimal 'price', precision: 10
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'profiles', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name'
    t.date 'dob'
    t.integer 'age', limit: 2
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'subject_chapters', charset: 'utf8mb3', force: :cascade do |t|
    t.bigint 'subject_id', null: false
    t.bigint 'chapter_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['chapter_id'], name: 'index_subject_chapters_on_chapter_id'
    t.index ['subject_id'], name: 'index_subject_chapters_on_subject_id'
  end

  create_table 'subjects', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.string 'image_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'title'
    t.string 'fname'
    t.string 'mname'
    t.string 'lname'
    t.string 'password_digest'
    t.string 'email'
    t.string 'mobile_number', null: false
    t.string 'state'
    t.string 'type'
    t.string 'referral_code'
    t.bigint 'referrer_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['mobile_number'], name: 'index_users_on_mobile_number', unique: true
    t.index ['referrer_id'], name: 'index_users_on_referrer_id'
    t.index ['state'], name: 'index_users_on_state'
  end

  add_foreign_key 'course_subjects', 'courses'
  add_foreign_key 'course_subjects', 'subjects'
  add_foreign_key 'subject_chapters', 'chapters'
  add_foreign_key 'subject_chapters', 'subjects'
  add_foreign_key 'users', 'users', column: 'referrer_id'
end
