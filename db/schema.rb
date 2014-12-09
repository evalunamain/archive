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

ActiveRecord::Schema.define(version: 20141209195122) do

  create_table "comments", force: true do |t|
    t.text     "content",           null: false
    t.integer  "author_id",         null: false
    t.integer  "post_id",           null: false
    t.integer  "parent_comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id"
  add_index "comments", ["parent_comment_id"], name: "index_comments_on_parent_comment_id"
  add_index "comments", ["post_id"], name: "index_comments_on_post_id"

  create_table "post_subs", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "sub_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_subs", ["post_id"], name: "index_post_subs_on_post_id"
  add_index "post_subs", ["sub_id"], name: "index_post_subs_on_sub_id"

  create_table "posts", force: true do |t|
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content"
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id"

  create_table "subs", force: true do |t|
    t.string   "title",        null: false
    t.text     "description",  null: false
    t.integer  "moderator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subs", ["moderator_id"], name: "index_subs_on_moderator_id"
  add_index "subs", ["title", "moderator_id"], name: "index_subs_on_title_and_moderator_id", unique: true

  create_table "users", force: true do |t|
    t.string   "username",                         null: false
    t.string   "session_token",                    null: false
    t.string   "password_digest",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "moderator_status", default: false
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true

end
