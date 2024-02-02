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

ActiveRecord::Schema.define(version: 2024_01_25_014237) do

  create_table "movies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 160, null: false, comment: "映画のタイトル。邦題・洋題は一旦考えなくてOK"
    t.string "year", limit: 45, comment: "公開年"
    t.text "description", comment: "映画の説明文"
    t.string "image_url", limit: 150, comment: "映画のポスター画像が格納されているURL"
    t.boolean "is_showing", null: false, comment: "上映中かどうか"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_movies_on_name", unique: true
  end

  create_table "rankings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.integer "reserved_count", null: false, comment: "予約数"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_rankings_on_movie_id"
  end

  create_table "reservations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "date", null: false
    t.bigint "schedule_id", null: false
    t.bigint "sheet_id", null: false
    t.string "email", null: false, comment: "予約者メールアドレス"
    t.string "name", null: false, comment: "予約者名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "screen_id"
    t.bigint "theater_id"
    t.index ["date", "schedule_id", "sheet_id"], name: "index_reservations_on_date_and_ids", unique: true
    t.index ["schedule_id"], name: "index_reservations_on_schedule_id"
    t.index ["screen_id"], name: "index_reservations_on_screen_id"
    t.index ["sheet_id"], name: "index_reservations_on_sheet_id"
    t.index ["theater_id"], name: "index_reservations_on_theater_id"
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.time "start_time", null: false, comment: "上映開始時刻"
    t.time "end_time", null: false, comment: "上映終了時刻"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "theater_id"
    t.bigint "screen_id"
    t.index ["movie_id"], name: "index_schedules_on_movie_id"
    t.index ["screen_id"], name: "index_schedules_on_screen_id"
    t.index ["theater_id"], name: "index_schedules_on_theater_id"
  end

  create_table "screens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "screen_number", null: false, comment: "スクリーン番号"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sheets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "column", null: false, comment: "座席の列番号"
    t.string "row", limit: 1, null: false, comment: "座席の行番号"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "theaters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rankings", "movies"
  add_foreign_key "reservations", "schedules"
  add_foreign_key "reservations", "screens"
  add_foreign_key "reservations", "sheets"
  add_foreign_key "reservations", "theaters"
  add_foreign_key "schedules", "movies"
  add_foreign_key "schedules", "screens"
  add_foreign_key "schedules", "theaters"
end
