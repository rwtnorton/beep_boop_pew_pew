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

ActiveRecord::Schema.define(:version => 20160926042333) do

  create_table "games", :force => true do |t|
    t.string   "name",                                :null => false
    t.integer  "publication_year"
    t.string   "notes"
    t.boolean  "is_active",        :default => false, :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "likes_count",      :default => 0,     :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "game_id",    :null => false
    t.string   "ip_addr",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "likes", ["created_at"], :name => "index_likes_on_created_at"
  add_index "likes", ["game_id", "ip_addr"], :name => "index_likes_on_game_id_and_ip_addr", :unique => true

  create_table "manufacturers", :force => true do |t|
    t.integer  "game_id",                    :null => false
    t.string   "company",                    :null => false
    t.string   "region",     :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "manufacturers", ["company", "region"], :name => "index_manufacturers_on_company_and_region"
  add_index "manufacturers", ["game_id", "company", "region"], :name => "index_manufacturers_on_game_id_and_company_and_region", :unique => true
  add_index "manufacturers", ["game_id", "company"], :name => "index_manufacturers_on_game_id_and_company"

  create_table "regions", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
