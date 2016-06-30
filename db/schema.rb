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

ActiveRecord::Schema.define(version: 20160630015950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.text     "location"
    t.string   "category",                        limit: 255
    t.text     "title"
    t.text     "description"
    t.string   "source",                          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date_published",                  limit: 255
    t.string   "notes",                           limit: 255
    t.text     "image"
    t.string   "publish",                         limit: 255
    t.string   "article_format",                  limit: 255
    t.string   "img_size",                        limit: 255
    t.string   "orig_content_photo_file_name",    limit: 255
    t.string   "orig_content_photo_content_type", limit: 255
    t.integer  "orig_content_photo_file_size"
    t.datetime "orig_content_photo_updated_at"
  end

  create_table "complaints", force: :cascade do |t|
    t.string   "cust_first_name",       limit: 255
    t.string   "cust_last_name",        limit: 255
    t.string   "customer_email",        limit: 255
    t.text     "complaint_description"
    t.string   "accused_seller",        limit: 255
    t.string   "order_id_number",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website",    limit: 255
  end

  create_table "email_digests", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     limit: 255
  end

  create_table "merchant_applications", force: :cascade do |t|
    t.string   "merchant_name",          limit: 255
    t.string   "email",                  limit: 255
    t.string   "country",                limit: 255
    t.string   "state_prov",             limit: 255
    t.string   "zip_postal",             limit: 255
    t.string   "city",                   limit: 255
    t.string   "street_address",         limit: 255
    t.string   "contact_name",           limit: 255
    t.string   "merchant_phone",         limit: 255
    t.boolean  "current_selling_online"
    t.string   "website_url",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merchant_orders", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "order_status"
    t.string   "delivery_method",   limit: 255
    t.integer  "product_id"
    t.text     "customer_comments"
  end

  create_table "order_units", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "unit_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street_address",   limit: 255
    t.string   "prov_state",       limit: 255
    t.string   "country",          limit: 255
    t.string   "postal_zip",       limit: 255
    t.string   "cust_first_name",  limit: 255
    t.string   "cust_last_name",   limit: 255
    t.string   "cust_email",       limit: 255
    t.string   "cust_phone",       limit: 255
    t.boolean  "marketing_optout"
    t.decimal  "amount",                       precision: 8, scale: 2
    t.string   "city",             limit: 255
    t.decimal  "sales_tax",                    precision: 8, scale: 2
    t.decimal  "shipping",                     precision: 8, scale: 2
    t.string   "transaction_id",   limit: 255
    t.boolean  "success"
  end

  create_table "orders_products", id: false, force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
  end

  add_index "orders_products", ["order_id"], name: "index_orders_products_on_order_id", using: :btree
  add_index "orders_products", ["product_id"], name: "index_orders_products_on_product_id", using: :btree

  create_table "product_categories", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_subcategories", force: :cascade do |t|
    t.string   "subcategory",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_category_id"
  end

  create_table "productfotos", force: :cascade do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "foto_file_name",    limit: 255
    t.string   "foto_content_type", limit: 255
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

  add_index "productfotos", ["product_id"], name: "index_productfotos_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.text     "description"
    t.boolean  "status"
    t.integer  "user_id"
    t.decimal  "price",                               precision: 8, scale: 2
    t.string   "currency",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name",         limit: 255
    t.string   "photo_content_type",      limit: 255
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "product_category",        limit: 255
    t.string   "product_subcategory",     limit: 255
    t.string   "product_sub_subcategory", limit: 255
    t.decimal  "shipping_charge",                     precision: 8, scale: 2
    t.text     "size_details"
    t.text     "product_return_policy"
  end

  create_table "results", force: :cascade do |t|
    t.string   "date",       limit: 255
    t.string   "city",       limit: 255
    t.string   "country",    limit: 255
    t.string   "format",     limit: 255
    t.text     "location"
    t.string   "category",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.text     "summary"
    t.string   "province",   limit: 255
    t.string   "city",       limit: 255
    t.string   "country",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", force: :cascade do |t|
    t.integer  "product_id"
    t.text     "size"
    t.integer  "quantity"
    t.integer  "quantity_sold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "colour",        limit: 255
  end

  create_table "user_feedback_answers", force: :cascade do |t|
    t.string   "answer_one"
    t.string   "answer_two"
    t.string   "answer_three"
    t.string   "answer_four"
    t.string   "answer_five"
    t.string   "answer_six"
    t.integer  "user_feedback_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "user_feedback_answers", ["user_feedback_id"], name: "index_user_feedback_answers_on_user_feedback_id", using: :btree

  create_table "user_feedbacks", force: :cascade do |t|
    t.string   "question_one"
    t.string   "question_two"
    t.string   "question_three"
    t.string   "question_four"
    t.string   "question_five"
    t.string   "question_six"
    t.integer  "article_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "user_feedbacks", ["article_id"], name: "index_user_feedbacks_on_article_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,                         default: "",    null: false
    t.string   "encrypted_password",     limit: 255,                         default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                              default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                                      default: false
    t.string   "merchant_name",          limit: 255
    t.string   "contact_name",           limit: 255
    t.string   "country",                limit: 255
    t.string   "state_prov",             limit: 255
    t.string   "zip_postal",             limit: 255
    t.string   "merchant_url",           limit: 255
    t.string   "merchant_phone",         limit: 255
    t.string   "street_address",         limit: 255
    t.decimal  "shipping_cost",                      precision: 8, scale: 2
    t.decimal  "sales_tax",                          precision: 2, scale: 2
    t.string   "city",                   limit: 255
    t.text     "user_return_policy"
    t.string   "slug",                   limit: 255
    t.boolean  "merchant"
    t.boolean  "article_publisher"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "user_feedback_answers", "user_feedbacks"
end
