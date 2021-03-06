# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090610055951) do

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "height"
    t.string   "weight"
    t.text     "description"
    t.text     "history"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",  :default => 1
    t.integer  "modified_by", :default => 1
    t.integer  "universe_id", :default => 1
  end

  create_table "characters_events", :id => false, :force => true do |t|
    t.integer "character_id", :null => false
    t.integer "event_id",     :null => false
  end

  add_index "characters_events", ["character_id", "event_id"], :name => "index_characters_events_on_character_id_and_event_id", :unique => true

  create_table "characters_organizations", :id => false, :force => true do |t|
    t.integer "character_id",    :null => false
    t.integer "organization_id", :null => false
  end

  add_index "characters_organizations", ["character_id", "organization_id"], :name => "index_characters_organizations_on_character_id_and_organization_id", :unique => true

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",  :default => 1
    t.integer  "modified_by", :default => 1
    t.integer  "universe_id", :default => 1
  end

  create_table "experiences", :force => true do |t|
    t.string   "name"
    t.integer  "character_id"
    t.integer  "event_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",   :default => 1
    t.integer  "modified_by",  :default => 1
    t.integer  "universe_id",  :default => 1
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",  :default => 1
    t.integer  "modified_by", :default => 1
    t.integer  "universe_id", :default => 1
  end

  create_table "my_qualities", :force => true do |t|
    t.integer  "level"
    t.integer  "quality_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_stats", :force => true do |t|
    t.integer  "level"
    t.integer  "stat_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.text     "mission_statement"
    t.text     "agenda"
    t.integer  "manpower"
    t.integer  "specialists"
    t.integer  "transportation"
    t.integer  "internal_security"
    t.integer  "firepower"
    t.integer  "knowledge"
    t.integer  "publicity"
    t.integer  "public_relations"
    t.integer  "intrusion"
    t.integer  "slush_funds"
    t.integer  "bases"
    t.integer  "bureaucracy"
    t.integer  "universe_id"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qualities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "required_stats", :force => true do |t|
    t.integer  "universe_id"
    t.integer  "stat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universes", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userlimits", :force => true do |t|
    t.integer  "universe_id"
    t.integer  "user_id"
    t.integer  "rights"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_universe_id"
  end

end
