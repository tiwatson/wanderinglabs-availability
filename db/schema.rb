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

ActiveRecord::Schema.define(version: 20140725045739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availability_request_notifcations", force: true do |t|
    t.integer  "availability_request_id"
    t.string   "site"
    t.date     "date_start"
    t.date     "date_end"
    t.integer  "days_length"
    t.datetime "notified_at"
    t.boolean  "available",               default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "availability_requests", force: true do |t|
    t.integer  "location_id"
    t.string   "email"
    t.boolean  "active",       default: false, null: false
    t.date     "date_start"
    t.date     "date_end"
    t.integer  "days_length"
    t.integer  "site_type"
    t.integer  "electric"
    t.boolean  "water",        default: false, null: false
    t.boolean  "sewer",        default: false, null: false
    t.boolean  "pullthru",     default: false, null: false
    t.boolean  "waterfront",   default: false, null: false
    t.datetime "last_checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string "name"
    t.string "slug"
    t.string "park_id"
    t.string "state"
  end

end
