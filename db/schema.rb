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

ActiveRecord::Schema.define(version: 20150717072032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"
  enable_extension "pg_trgm"

  create_table "airports", force: :cascade do |t|
    t.string   "fs"
    t.string   "iata"
    t.string   "icao"
    t.string   "name"
    t.string   "city"
    t.string   "city_code"
    t.string   "country_code"
    t.string   "country_name"
    t.string   "region_name"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "elevation_feet"
    t.integer  "classification"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "queries", force: :cascade do |t|
    t.integer  "destination_id"
    t.integer  "origin_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer  "query_id"
    t.integer  "airport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.integer  "destination_id"
    t.integer  "origin_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "stopovers", force: :cascade do |t|
    t.integer  "airport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ways", force: :cascade do |t|
    t.integer  "destination_id"
    t.integer  "origin_id"
    t.integer  "stopovers_array", default: [],              array: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end
