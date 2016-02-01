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

ActiveRecord::Schema.define(version: 20160201065636) do

  create_table "days", force: :cascade do |t|
    t.integer  "number",            limit: 4
    t.string   "modal_title",       limit: 255
    t.integer  "previous_day_id",   limit: 4
    t.integer  "next_day_id",       limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "route_id",          limit: 4
    t.text     "modal_content",     limit: 65535
    t.string   "icon_file_name",    limit: 255
    t.string   "icon_content_type", limit: 255
    t.integer  "icon_file_size",    limit: 4
    t.datetime "icon_updated_at"
  end

  create_table "departures", force: :cascade do |t|
    t.integer  "route_id",   limit: 4
    t.datetime "start_time"
    t.integer  "seats",      limit: 4
    t.integer  "price",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "high_lights", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "tour_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "main_slides", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "order",              limit: 4
    t.boolean  "active",             limit: 1
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "routes", force: :cascade do |t|
    t.integer  "tour_id",      limit: 4
    t.string   "name",         limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "descriptions", limit: 65535
  end

  create_table "shards", force: :cascade do |t|
    t.integer  "order",              limit: 4
    t.integer  "tour_avator_id",     limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "slides", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "tour_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.string   "key",        limit: 255
    t.datetime "expires_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tour_categories", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "icon_file_name",    limit: 255
    t.string   "icon_content_type", limit: 255
    t.integer  "icon_file_size",    limit: 4
    t.datetime "icon_updated_at"
    t.integer  "order",             limit: 4
  end

  create_table "tour_categories_tours", force: :cascade do |t|
    t.integer "tour_id",          limit: 4
    t.integer "tour_category_id", limit: 4
  end

  add_index "tour_categories_tours", ["tour_category_id"], name: "index_tour_categories_tours_on_tour_category_id", using: :btree
  add_index "tour_categories_tours", ["tour_id"], name: "index_tour_categories_tours_on_tour_id", using: :btree

  create_table "tours", force: :cascade do |t|
    t.string   "name",                             limit: 255
    t.string   "slider_subtitle",                  limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "tour_map_file_name",               limit: 255
    t.string   "tour_map_content_type",            limit: 255
    t.integer  "tour_map_file_size",               limit: 4
    t.datetime "tour_map_updated_at"
    t.text     "features",                         limit: 65535
    t.text     "terms",                            limit: 65535
    t.string   "cover_title",                      limit: 255
    t.string   "cover_image_large_file_name",      limit: 255
    t.string   "cover_image_large_content_type",   limit: 255
    t.integer  "cover_image_large_file_size",      limit: 4
    t.datetime "cover_image_large_updated_at"
    t.string   "cover_image_small_a_file_name",    limit: 255
    t.string   "cover_image_small_a_content_type", limit: 255
    t.integer  "cover_image_small_a_file_size",    limit: 4
    t.datetime "cover_image_small_a_updated_at"
    t.string   "cover_image_small_b_file_name",    limit: 255
    t.string   "cover_image_small_b_content_type", limit: 255
    t.integer  "cover_image_small_b_file_size",    limit: 4
    t.datetime "cover_image_small_b_updated_at"
    t.string   "cover_image_small_c_file_name",    limit: 255
    t.string   "cover_image_small_c_content_type", limit: 255
    t.integer  "cover_image_small_c_file_size",    limit: 4
    t.datetime "cover_image_small_c_updated_at"
    t.string   "cover_image_small_d_file_name",    limit: 255
    t.string   "cover_image_small_d_content_type", limit: 255
    t.integer  "cover_image_small_d_file_size",    limit: 4
    t.datetime "cover_image_small_d_updated_at"
    t.string   "cover_info",                       limit: 255
    t.integer  "order",                            limit: 4
    t.string   "wechat_share_title",               limit: 255
    t.string   "wechat_share_description",         limit: 255
    t.string   "wechat_share_icon_file_name",      limit: 255
    t.string   "wechat_share_icon_content_type",   limit: 255
    t.integer  "wechat_share_icon_file_size",      limit: 4
    t.datetime "wechat_share_icon_updated_at"
    t.string   "content_image_file_name",          limit: 255
    t.string   "content_image_content_type",       limit: 255
    t.integer  "content_image_file_size",          limit: 4
    t.datetime "content_image_updated_at"
    t.string   "type",                             limit: 255
    t.boolean  "active",                           limit: 1
  end

end
