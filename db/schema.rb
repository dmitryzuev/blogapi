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

ActiveRecord::Schema.define(version: 20160207205152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ip_usernames", force: :cascade do |t|
    t.string "ip"
    t.string "username"
  end

  add_index "ip_usernames", ["ip", "username"], name: "index_ip_usernames_on_ip_and_username", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.string   "ip",         limit: 45
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "score",      limit: 2
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "ratings", ["post_id"], name: "index_ratings_on_post_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "posts", "users"
  add_foreign_key "ratings", "posts"
end
