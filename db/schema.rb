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

ActiveRecord::Schema.define(:version => 20121126005032) do

  create_table "leafs", :force => true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lon"
    t.float    "alt"
    t.binary   "sha"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "nodes", :force => true do |t|
    t.binary   "parent"
    t.binary   "l_child"
    t.binary   "r_child"
    t.binary   "sha"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "level"
    t.boolean  "is_right_child"
  end

end
