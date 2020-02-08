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

ActiveRecord::Schema.define(version: 2020_02_07_222939) do

  create_table "bookmarks", force: :cascade do |t|
    t.string "quake_db_id"
    t.string "place"
    t.string "dateAndTime"
    t.integer "mag"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lat"
    t.integer "long"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "commented_quakes", force: :cascade do |t|
    t.string "quake_db_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "commented_quake_id", null: false
    t.string "date_posted"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "quake_name"
    t.integer "quake_mag"
    t.index ["commented_quake_id"], name: "index_comments_on_commented_quake_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "radius_concern"
  end

  add_foreign_key "comments", "commented_quakes"
  add_foreign_key "comments", "users"
end
