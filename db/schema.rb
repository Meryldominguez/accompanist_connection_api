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

ActiveRecord::Schema[7.1].define(version: 2024_03_18_010838) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instruments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_instruments_on_name"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "instrument_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_profiles_on_instrument_id"
    t.index ["user_id", "instrument_id"], name: "index_profiles_on_user_id_and_instrument_id", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rollout_overrides", force: :cascade do |t|
    t.string "resource_type", null: false
    t.bigint "resource_id", null: false
    t.bigint "rollout_id"
    t.boolean "allow", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id", "resource_type", "rollout_id"], name: "idx_on_resource_id_resource_type_rollout_id_670d96db44", unique: true
    t.index ["resource_type", "resource_id"], name: "index_rollout_overrides_on_resource"
    t.index ["rollout_id"], name: "index_rollout_overrides_on_rollout_id"
  end

  create_table "rollouts", force: :cascade do |t|
    t.string "name"
    t.integer "percent_enabled", default: 0, null: false
    t.integer "offset", default: 0
    t.string "resource_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "unique_name", unique: true
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "Only one user_role per user per role", unique: true
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.decimal "latitude", precision: 8, scale: 6
    t.decimal "longitude", precision: 9, scale: 6
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.datetime "confirmed_at"
    t.index ["email"], name: "unique_emails", unique: true
  end

  add_foreign_key "profiles", "instruments"
  add_foreign_key "profiles", "users"
  add_foreign_key "rollout_overrides", "rollouts"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
