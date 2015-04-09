# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150409204101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignations", force: :cascade do |t|
    t.integer  "schedule_id"
    t.integer  "term_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "assignations", ["schedule_id"], name: "index_assignations_on_schedule_id", using: :btree
  add_index "assignations", ["term_id"], name: "index_assignations_on_term_id", using: :btree

  create_table "instructors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "instructor_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "terms", ["instructor_id"], name: "index_terms_on_instructor_id", using: :btree
  add_index "terms", ["starts_at", "subject_id", "instructor_id"], name: "index_terms_on_starts_at_and_subject_id_and_instructor_id", unique: true, using: :btree
  add_index "terms", ["subject_id"], name: "index_terms_on_subject_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                            null: false
    t.string   "student_number"
    t.string   "email",                               null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
