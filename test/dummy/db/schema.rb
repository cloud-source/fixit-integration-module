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

ActiveRecord::Schema.define(version: 20171011010816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "fix_it_integration_services", force: :cascade do |t|
    t.text     "url",        null: false
    t.text     "auth",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fix_it_integration_settings", force: :cascade do |t|
    t.integer  "channel_id",                                                          null: false
    t.geometry "geom",                          limit: {:srid=>0, :type=>"geometry"}, null: false
    t.text     "fault_description",                                                   null: false
    t.integer  "branded_app_id",                                                      null: false
    t.integer  "fix_it_integration_service_id"
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.index ["fix_it_integration_service_id"], name: "settings service", using: :btree
  end

  add_foreign_key "fix_it_integration_settings", "fix_it_integration_services"
end
