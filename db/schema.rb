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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121127041919) do

  create_table "leafs", :force => true do |t|
    t.string   "name"
    t.float    "lat0"
    t.float    "lon0"
    t.float    "alt0"
    t.binary   "sha"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "certificate_file_name"
    t.string   "certificate_content_type"
    t.integer  "certificate_file_size"
    t.datetime "certificate_updated_at"
    t.float    "lat1"
    t.float    "lon1"
    t.float    "alt1"
  end

  create_table "nodes", :force => true do |t|
    t.integer  "parent"
    t.integer  "l_child"
    t.integer  "r_child"
    t.binary   "sha"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "level"
    t.boolean  "is_right_child"
  end

end
