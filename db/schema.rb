# -*- encoding : utf-8 -*-
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

ActiveRecord::Schema.define(version: 20150728102041) do

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "lang_id",    limit: 4
    t.integer  "country_id", limit: 4
    t.integer  "region_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "iso2",         limit: 255
    t.string   "short_name",   limit: 255
    t.string   "long_name",    limit: 255
    t.string   "iso3",         limit: 255
    t.string   "numcode",      limit: 255
    t.string   "un_member",    limit: 255
    t.string   "calling_code", limit: 255
    t.string   "cctld",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "fuel_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "country_id",   limit: 4
    t.integer  "region_id",    limit: 4
    t.integer  "city_id",      limit: 4
    t.integer  "trademark_id", limit: 4
    t.integer  "fuel_type_id", limit: 4
    t.float    "cost",         limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "lang_id",    limit: 4
    t.integer  "country_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "trademarks", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "operator_name", limit: 255
    t.string   "lang_id",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
