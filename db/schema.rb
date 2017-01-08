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

ActiveRecord::Schema.define(version: 20170108125932) do

  create_table "images", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "user_id",            limit: 4
  end

  create_table "managers", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true, using: :btree
  add_index "managers", ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true, using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "author",      limit: 255
    t.string   "title",       limit: 255
    t.text     "content",     limit: 65535
    t.boolean  "is_editable"
    t.string   "link_text",   limit: 255
    t.string   "link_site",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "post_authorities", force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "post_id", limit: 4
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           limit: 255,   default: "",        null: false
    t.string   "encrypted_password",              limit: 255,   default: "",        null: false
    t.string   "reset_password_token",            limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   limit: 4,     default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",              limit: 255
    t.string   "last_sign_in_ip",                 limit: 255
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "fb_uid",                          limit: 255
    t.string   "fb_token",                        limit: 255
    t.string   "fb_image",                        limit: 255
    t.string   "fb_name",                         limit: 255
    t.string   "provider",                        limit: 255
    t.string   "taiwan_name",                     limit: 255
    t.string   "english_name",                    limit: 255
    t.text     "profile",                         limit: 65535
    t.text     "paper",                           limit: 65535
    t.boolean  "has_graduated",                                 default: false
    t.string   "academic_degree",                 limit: 255,   default: "college"
    t.integer  "joined_CYCU_at_which_year",       limit: 4
    t.integer  "has_spent_how_much_time_at_CYCU", limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
