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

ActiveRecord::Schema.define(version: 20160527211344) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "shop_id",    limit: 4
    t.float    "rate",       limit: 24
    t.string   "comments",   limit: 250
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "comments", ["shop_id"], name: "index_comments_on_shop_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "shops", force: :cascade do |t|
    t.string   "shopname",   limit: 50,                  null: false
    t.string   "address",    limit: 255
    t.float    "latitude",   limit: 24
    t.float    "longitude",  limit: 24
    t.boolean  "visible",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.time     "topen"
    t.time     "tclose"
  end

  create_table "shops_users", id: false, force: :cascade do |t|
    t.integer "shop_id", limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "shops_users", ["shop_id", "user_id"], name: "index_shops_users_on_shop_id_and_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 30,                  null: false
    t.string   "email",           limit: 255, default: "",    null: false
    t.boolean  "privilege",                   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "password_digest", limit: 255
  end

  create_table "users_shops", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "shop_id", limit: 4
  end

  add_index "users_shops", ["user_id", "shop_id"], name: "index_users_shops_on_user_id_and_shop_id", using: :btree

end
