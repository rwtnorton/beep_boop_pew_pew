# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_13_044913) do
  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.integer "publication_year"
    t.string "notes"
    t.boolean "is_active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.index ["name"], name: "index_games_on_name"
    t.index ["publication_year"], name: "index_games_on_publication_year"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "ip_addr", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_likes_on_created_at"
    t.index ["game_id", "ip_addr"], name: "index_likes_on_game_id_and_ip_addr", unique: true
    t.index ["game_id"], name: "index_likes_on_game_id"
    t.index ["ip_addr"], name: "index_likes_on_ip_addr"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "company", null: false
    t.string "region", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company", "region"], name: "index_manufacturers_on_company_and_region"
    t.index ["company"], name: "index_manufacturers_on_company"
    t.index ["game_id", "company", "region"], name: "index_manufacturers_on_game_id_and_company_and_region", unique: true
    t.index ["game_id", "company"], name: "index_manufacturers_on_game_id_and_company"
    t.index ["game_id"], name: "index_manufacturers_on_game_id"
    t.index ["region"], name: "index_manufacturers_on_region"
  end

end
