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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140204185836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_body_temps", force: true do |t|
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "product_id"
    t.integer  "client_bill_head_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_bill_bodies", force: true do |t|
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "product_id"
    t.integer  "client_bill_head_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_bill_body_temps", force: true do |t|
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "product_id"
    t.integer  "client_bill_head_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_bill_heads", force: true do |t|
    t.date     "date"
    t.integer  "number"
    t.string   "type"
    t.integer  "total"
    t.float    "total_iva"
    t.integer  "client_id"
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_current_accounts", force: true do |t|
    t.integer  "client_id"
    t.integer  "client_bill_head_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "client_fees", force: true do |t|
    t.integer  "ammount"
    t.date     "expiration_date"
    t.date     "payment_date"
    t.integer  "client_current_account_id"
    t.integer  "receipt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ammount_paid"
  end

  create_table "client_phones", force: true do |t|
    t.string   "phone"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_receipts", force: true do |t|
    t.integer  "ammount"
    t.integer  "client_id"
    t.integer  "number"
    t.integer  "client_current_account_id"
    t.string   "description"
    t.date     "date"
    t.integer  "first_payment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "cod"
    t.string   "name"
    t.string   "last_name"
    t.string   "address"
    t.string   "job_address"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ivas", force: true do |t|
    t.integer  "iva"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_data", force: true do |t|
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "cod"
    t.string   "description"
    t.integer  "surcharge"
    t.integer  "category_id"
    t.integer  "iva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salesmen", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_bill_bodies", force: true do |t|
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "supplier_bill_head_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_bill_heads", force: true do |t|
    t.date     "date"
    t.string   "number"
    t.string   "type"
    t.float    "total"
    t.integer  "supplier_id"
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.string   "direction"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: true do |t|
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "name"
    t.integer  "user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
