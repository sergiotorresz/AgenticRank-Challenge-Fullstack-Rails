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

ActiveRecord::Schema[7.1].define(version: 2026_01_01_000003) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "product", null: false
    t.float "goal", null: false
    t.integer "annual_rate_bps", null: false
    t.integer "term_months", null: false
    t.string "status", default: "open", null: false
    t.date "closes_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investments", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "investor_id", null: false
    t.float "amount", null: false
    t.string "idempotency_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_investments_on_campaign_id"
    t.index ["idempotency_key"], name: "index_investments_on_idempotency_key"
    t.index ["investor_id"], name: "index_investments_on_investor_id"
  end

  create_table "investors", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_investors_on_email", unique: true
  end

  add_foreign_key "investments", "campaigns"
  add_foreign_key "investments", "investors"
end
