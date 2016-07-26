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

ActiveRecord::Schema.define(version: 20160726220914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer  "card_id"
    t.string   "name"
    t.string   "number"
    t.string   "skill"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "img"
  end

  create_table "members", force: :cascade do |t|
    t.integer  "card_id"
    t.string   "birthday"
    t.string   "grade"
    t.string   "piece1"
    t.string   "piece2"
    t.string   "piece3"
    t.string   "piece4"
    t.string   "bonus"
    t.string   "ability"
    t.string   "costume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rarity"
  end

  create_table "musics", force: :cascade do |t|
    t.integer  "card_id"
    t.string   "color"
    t.integer  "live_p_base"
    t.string   "live_p_extra"
    t.integer  "score_red"
    t.integer  "score_green"
    t.integer  "score_blue"
    t.integer  "score_common"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
