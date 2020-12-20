# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_20_084238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_follows", force: :cascade do |t|
    t.bigint "requester_id"
    t.bigint "addressee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressee_id"], name: "index_user_follows_on_addressee_id"
    t.index ["requester_id"], name: "index_user_follows_on_requester_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "user_follows", "users", column: "addressee_id"
  add_foreign_key "user_follows", "users", column: "requester_id"
end
