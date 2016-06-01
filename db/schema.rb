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

ActiveRecord::Schema.define(version: 20160504193019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.text     "location"
    t.string   "category"
    t.text     "title"
    t.text     "description"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date_published"
    t.string   "notes"
    t.text     "image"
    t.string   "publish"
    t.string   "article_format"
    t.string   "img_size"
    t.string   "orig_content_photo_file_name"
    t.string   "orig_content_photo_content_type"
    t.integer  "orig_content_photo_file_size"
    t.datetime "orig_content_photo_updated_at"
  end

  create_table "complaints", force: true do |t|
    t.string   "cust_first_name"
    t.string   "cust_last_name"
    t.string   "customer_email"
    t.text     "complaint_description"
    t.string   "accused_seller"
    t.string   "order_id_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
  end

  create_table "email_digests", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "merchant_applications", force: true do |t|
    t.string   "merchant_name"
    t.string   "email"
    t.string   "country"
    t.string   "state_prov"
    t.string   "zip_postal"
    t.string   "city"
    t.string   "street_address"
    t.string   "contact_name"
    t.string   "merchant_phone"
    t.boolean  "current_selling_online"
    t.string   "website_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merchant_orders", force: true do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "order_status"
    t.string   "delivery_method"
    t.integer  "product_id"
    t.text     "customer_comments"
  end

  create_table "order_units", force: true do |t|
    t.integer  "order_id"
    t.integer  "unit_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street_address"
    t.string   "prov_state"
    t.string   "country"
    t.string   "postal_zip"
    t.string   "cust_first_name"
    t.string   "cust_last_name"
    t.string   "cust_email"
    t.string   "cust_phone"
    t.boolean  "marketing_optout"
    t.decimal  "amount",           precision: 8, scale: 2
    t.string   "city"
    t.decimal  "sales_tax",        precision: 8, scale: 2
    t.decimal  "shipping",         precision: 8, scale: 2
    t.string   "transaction_id"
  end

  create_table "orders_products", id: false, force: true do |t|
    t.integer "order_id"
    t.integer "product_id"
  end

  add_index "orders_products", ["order_id"], name: "index_orders_products_on_order_id", using: :btree
  add_index "orders_products", ["product_id"], name: "index_orders_products_on_product_id", using: :btree

  create_table "product_categories", force: true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_subcategories", force: true do |t|
    t.string   "subcategory"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_category_id"
  end

  create_table "productfotos", force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

  add_index "productfotos", ["product_id"], name: "index_productfotos_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "status"
    t.integer  "user_id"
    t.decimal  "price",                   precision: 8, scale: 2
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "product_category"
    t.string   "product_subcategory"
    t.string   "product_sub_subcategory"
    t.decimal  "shipping_charge",         precision: 8, scale: 2
    t.text     "size_details"
    t.text     "product_return_policy"
  end

  create_table "results", force: true do |t|
    t.string   "date"
    t.string   "city"
    t.string   "country"
    t.string   "format"
    t.text     "location"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "summary"
    t.string   "province"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", force: true do |t|
    t.integer  "product_id"
    t.text     "size"
    t.integer  "quantity"
    t.integer  "quantity_sold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "colour"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                          default: "",    null: false
    t.string   "encrypted_password",                             default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                          default: false
    t.string   "merchant_name"
    t.string   "contact_name"
    t.string   "country"
    t.string   "state_prov"
    t.string   "zip_postal"
    t.string   "merchant_url"
    t.string   "merchant_phone"
    t.string   "street_address"
    t.decimal  "shipping_cost",          precision: 8, scale: 2
    t.decimal  "sales_tax",              precision: 2, scale: 2
    t.string   "city"
    t.text     "user_return_policy"
    t.string   "slug"
    t.boolean  "merchant"
    t.boolean  "article_publisher"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
