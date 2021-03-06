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

ActiveRecord::Schema.define(version: 20140925093844) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_pages", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "position"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agent_pages", ["agent_id"], name: "index_agent_pages_on_agent_id", using: :btree

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

  create_table "conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
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

  create_table "flags", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fleets", force: true do |t|
    t.string   "name"
    t.integer  "shipping_company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fleets", ["shipping_company_id"], name: "index_fleets_on_shipping_company_id", using: :btree

  create_table "labels", force: true do |t|
    t.integer  "notification_id"
    t.integer  "conversation_id"
    t.integer  "voyages_port_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labels", ["conversation_id"], name: "index_labels_on_conversation_id", using: :btree
  add_index "labels", ["notification_id"], name: "index_labels_on_notification_id", using: :btree
  add_index "labels", ["voyages_port_id"], name: "index_labels_on_voyages_port_id", using: :btree

  create_table "mercury_images", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "needs", force: true do |t|
    t.integer  "voyages_port_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "needs", ["service_id"], name: "index_needs_on_service_id", using: :btree

  create_table "notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], name: "index_notifications_on_conversation_id", using: :btree

  create_table "offers", force: true do |t|
    t.float    "value"
    t.integer  "quantity"
    t.boolean  "accepted"
    t.integer  "need_id"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["agent_id"], name: "index_offers_on_agent_id", using: :btree
  add_index "offers", ["need_id"], name: "index_offers_on_need_id", using: :btree

  create_table "operations", force: true do |t|
    t.integer  "agent_id"
    t.integer  "port_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operations", ["agent_id", "port_id"], name: "index_operations_on_agent_id_and_port_id", unique: true, using: :btree
  add_index "operations", ["agent_id"], name: "index_operations_on_agent_id", using: :btree
  add_index "operations", ["port_id"], name: "index_operations_on_port_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "shipping_company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "pages", ["shipping_company_id"], name: "index_pages_on_shipping_company_id", using: :btree

  create_table "ports", force: true do |t|
    t.string   "name"
    t.decimal  "lat",        precision: 15, scale: 10
    t.decimal  "lng",        precision: 15, scale: 10
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "readers", force: true do |t|
    t.integer  "user_id"
    t.integer  "notification_id"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "readers", ["conversation_id"], name: "index_readers_on_conversation_id", using: :btree
  add_index "readers", ["notification_id"], name: "index_readers_on_notification_id", using: :btree
  add_index "readers", ["user_id"], name: "index_readers_on_user_id", using: :btree

  create_table "receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "receipts", ["notification_id"], name: "index_receipts_on_notification_id", using: :btree

  create_table "senders", force: true do |t|
    t.integer  "user_id"
    t.integer  "notification_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "senders", ["notification_id"], name: "index_senders_on_notification_id", using: :btree
  add_index "senders", ["user_id"], name: "index_senders_on_user_id", using: :btree

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
    t.integer  "vessel_type_id"
    t.integer  "fleet_id"
    t.integer  "flag_id"
    t.integer  "port_id"
    t.integer  "registry_no"
    t.date     "built_date"
    t.string   "yard_built"
    t.integer  "imo_no"
    t.integer  "hull_no"
    t.string   "call_sign"
    t.float    "dwt_summer"
    t.float    "dwt_winter"
    t.float    "dwt_tropical_salt"
    t.float    "dwt_tropical_fresh"
    t.float    "dwt_winter_north_atlantic"
    t.float    "draft_summer"
    t.float    "draft_winter"
    t.float    "draft_tropical_salt"
    t.float    "draft_tropical_fresh"
    t.float    "draft_winter_north_atlantic"
    t.float    "grt"
    t.float    "nrt"
    t.float    "loa"
    t.float    "beam"
    t.float    "depth"
    t.float    "breadth"
    t.float    "design_draught"
    t.float    "ballast_capacity"
    t.float    "lightship"
    t.integer  "holds"
    t.integer  "cranes"
    t.float    "cranes_swl"
    t.float    "cranes_outreach"
    t.integer  "grabs"
    t.float    "grabs_capacity"
    t.integer  "no_engines"
    t.string   "builder"
    t.string   "engine_type"
    t.float    "engine_rating"
    t.float    "ncr_rpr"
    t.float    "me_rpm_at_mcr"
    t.float    "me_power_at_mcr"
    t.float    "horse_power"
    t.integer  "propellers_number"
    t.string   "propeller_type"
    t.float    "propeller_diameter"
    t.float    "pitch_mean"
    t.integer  "bts_number"
    t.integer  "sts_number"
    t.float    "bts_rating"
    t.float    "sts_rating"
    t.integer  "generators_number"
    t.float    "total_rating"
    t.float    "voltage_rating"
    t.float    "frequency"
    t.float    "ballast_manifold_height"
    t.float    "laden_manifold_height"
    t.float    "ifo_hose_inch"
    t.float    "mdo_hose_inch"
    t.float    "ifo_rate"
    t.float    "mdo_rate"
    t.string   "ifo_location"
    t.string   "mdo_location"
    t.string   "rudders_number"
    t.string   "steering_gear_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ships", ["flag_id"], name: "index_ships_on_flag_id", using: :btree
  add_index "ships", ["fleet_id"], name: "index_ships_on_fleet_id", using: :btree

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

  create_table "voyages_ports", force: true do |t|
    t.integer  "voyage_id"
    t.integer  "port_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remarks"
  end

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

end
