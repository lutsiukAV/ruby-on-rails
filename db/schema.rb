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

ActiveRecord::Schema.define(version: 20161106161248) do

  create_table "courses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "hours",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "courses", ["user_id"], name: "fk_rails_b3c61f05ef", using: :btree

  create_table "grades", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "mark",       limit: 4
    t.string   "comment",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "grades", ["course_id"], name: "fk_rails_492ccf8468", using: :btree
  add_index "grades", ["user_id"], name: "fk_rails_22730debfa", using: :btree

  create_table "records", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",      limit: 255
    t.string   "password",   limit: 255
    t.integer  "group",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "courses", "users"
  add_foreign_key "grades", "courses"
  add_foreign_key "grades", "users"
end
