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

ActiveRecord::Schema.define(version: 20160411030207) do

  create_table "bank_products", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "bank_id",    limit: 4
    t.integer  "product_id", limit: 4
  end

  add_index "bank_products", ["bank_id"], name: "index_bank_products_on_bank_id", using: :btree
  add_index "bank_products", ["product_id"], name: "index_bank_products_on_product_id", using: :btree

  create_table "banks", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.string   "nit",        limit: 255
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "code",        limit: 255
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "product_id",  limit: 4
  end

  add_index "products", ["product_id"], name: "index_products_on_product_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "minMonths",  limit: 4
    t.integer  "maxMonths",  limit: 4
    t.decimal  "value",                precision: 5, scale: 2
    t.integer  "bank_id",    limit: 4
    t.integer  "product_id", limit: 4
  end

  add_index "rates", ["bank_id"], name: "index_rates_on_bank_id", using: :btree
  add_index "rates", ["product_id"], name: "index_rates_on_product_id", using: :btree

  create_table "restrictions", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "minSalary",     limit: 4
    t.boolean  "employee"
    t.integer  "mesesemployee", limit: 4
    t.integer  "product_id",    limit: 4
  end

  add_index "restrictions", ["product_id"], name: "index_restrictions_on_product_id", using: :btree

  create_table "scanners", force: :cascade do |t|
    t.integer "salary",   limit: 4
    t.integer "term",     limit: 4
    t.decimal "amount",             precision: 10
    t.boolean "employee"
    t.boolean "active"
    t.boolean "tn_email"
    t.integer "user_id",  limit: 4
  end

  add_index "scanners", ["user_id"], name: "index_scanners_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "lastName",   limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "bank_products", "banks"
  add_foreign_key "bank_products", "products"
  add_foreign_key "products", "products"
  add_foreign_key "rates", "banks"
  add_foreign_key "rates", "products"
  add_foreign_key "restrictions", "products"
  add_foreign_key "scanners", "users"
end
