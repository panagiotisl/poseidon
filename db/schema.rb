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

ActiveRecord::Schema.define(version: 20131117084157) do

  create_table "agents", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "telephone"
    t.boolean  "enabled"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "iso"
    t.string   "name"
    t.string   "printableName"
    t.string   "iso3"
    t.integer  "numCode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree

  create_table "needs", force: true do |t|
    t.integer  "voyage_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "needs", ["service_id"], name: "index_needs_on_service_id", using: :btree

  create_table "operations", force: true do |t|
    t.integer  "agent_id"
    t.integer  "port_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operations", ["agent_id", "port_id"], name: "index_operations_on_agent_id_and_port_id", unique: true, using: :btree
  add_index "operations", ["agent_id"], name: "index_operations_on_agent_id", using: :btree
  add_index "operations", ["port_id"], name: "index_operations_on_port_id", using: :btree

  create_table "ports", force: true do |t|
    t.string   "name"
    t.decimal  "lat",        precision: 15, scale: 10
    t.decimal  "lng",        precision: 15, scale: 10
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_companies", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "telephone"
    t.boolean  "enabled"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ships", force: true do |t|
    t.string   "name"
    t.integer  "shipping_company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ships", ["shipping_company_id"], name: "index_ships_on_shipping_company_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin"
    t.integer  "shipping_company_id"
    t.integer  "agent_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "vessel_types", force: true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "voyages", force: true do |t|
    t.string   "name"
    t.integer  "ship_id"
    t.integer  "port_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "voyages", ["port_id"], name: "index_voyages_on_port_id", using: :btree
  add_index "voyages", ["ship_id"], name: "index_voyages_on_ship_id", using: :btree

end
