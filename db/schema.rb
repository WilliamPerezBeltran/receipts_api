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

ActiveRecord::Schema.define(version: 2019_11_26_234152) do

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "consignations", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "observation"
    t.integer "payment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_id"], name: "index_consignations_on_payment_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "name"
    t.integer "receipt_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receipt_id"], name: "index_payments_on_receipt_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "title"
    t.string "observation"
    t.integer "refund_id"
    t.integer "consignation_id"
    t.integer "payment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "attachments"
    t.index ["consignation_id"], name: "index_photos_on_consignation_id"
    t.index ["payment_id"], name: "index_photos_on_payment_id"
    t.index ["refund_id"], name: "index_photos_on_refund_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.integer "pay"
    t.integer "debt"
    t.string "number"
    t.string "status"
    t.date "date"
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_receipts_on_company_id"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "refunds", force: :cascade do |t|
    t.integer "value"
    t.integer "actual_payment"
    t.integer "actual_debt"
    t.integer "receipt_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receipt_id"], name: "index_refunds_on_receipt_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "consignations", "payments"
  add_foreign_key "payments", "receipts"
  add_foreign_key "photos", "consignations"
  add_foreign_key "photos", "payments"
  add_foreign_key "photos", "refunds"
  add_foreign_key "receipts", "companies"
  add_foreign_key "receipts", "users"
  add_foreign_key "refunds", "receipts"
end
