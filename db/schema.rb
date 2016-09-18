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

ActiveRecord::Schema.define(version: 20160910184314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
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

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "complaints", force: :cascade do |t|
    t.string   "cust_first_name"
    t.string   "cust_last_name"
    t.string   "customer_email"
    t.text     "complaint_description"
    t.string   "accused_seller"
    t.string   "order_id_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "alpha_2_code"
    t.string   "common_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "default_permitted_destinations", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "country_id"
  end

  add_index "default_permitted_destinations", ["user_id"], name: "index_default_permitted_destinations_on_user_id", using: :btree

  create_table "email_digests", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "merchant_applications", force: :cascade do |t|
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

  create_table "merchant_orders", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "order_status"
    t.string   "delivery_method"
    t.integer  "product_id"
    t.text     "customer_comments"
  end

  create_table "order_units", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "unit_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "sales_tax_charged", precision: 8, scale: 2
    t.decimal  "shipping_charged",  precision: 8, scale: 2
    t.string   "currency"
    t.decimal  "sub_total",         precision: 8, scale: 2
  end

  create_table "orders", force: :cascade do |t|
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
    t.boolean  "success"
    t.string   "currency"
  end

  create_table "orders_products", id: false, force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
  end

  add_index "orders_products", ["order_id"], name: "index_orders_products_on_order_id", using: :btree
  add_index "orders_products", ["product_id"], name: "index_orders_products_on_product_id", using: :btree

  create_table "permitted_destinations", force: :cascade do |t|
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "country_id"
  end

  add_index "permitted_destinations", ["product_id"], name: "index_permitted_destinations_on_product_id", using: :btree

  create_table "product_categories", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "product_id"
    t.integer  "category_id"
  end

  create_table "productfotos", force: :cascade do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

  add_index "productfotos", ["product_id"], name: "index_productfotos_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "status"
    t.integer  "user_id"
    t.decimal  "price",                 precision: 8, scale: 2, default: 0.0
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.decimal  "shipping_charge",       precision: 8, scale: 2
    t.text     "size_details"
    t.text     "product_return_policy"
    t.decimal  "usd_price",             precision: 8, scale: 2, default: 0.0
    t.decimal  "cad_price",             precision: 8, scale: 2, default: 0.0
    t.string   "factory_sku"
    t.decimal  "cad_domestic_shipping", precision: 8, scale: 2
    t.decimal  "cad_foreign_shipping",  precision: 8, scale: 2
    t.decimal  "usd_domestic_shipping", precision: 8, scale: 2
    t.decimal  "usd_foreign_shipping",  precision: 8, scale: 2
    t.string   "brand"
  end

  create_table "results", force: :cascade do |t|
    t.string   "date"
    t.string   "city"
    t.string   "country"
    t.string   "format"
    t.text     "location"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "returns", force: :cascade do |t|
    t.integer  "order_units_id"
    t.integer  "qty_returned"
    t.decimal  "amount_returned"
    t.text     "reason"
    t.integer  "unit_returned"
    t.integer  "order_id"
    t.boolean  "exchanged"
    t.decimal  "amount_to_charge"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "returns", ["order_id"], name: "index_returns_on_order_id", using: :btree
  add_index "returns", ["order_units_id"], name: "index_returns_on_order_units_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "abbreviation"
    t.string   "common_name"
    t.integer  "country_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "teams", force: :cascade do |t|
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

  create_table "units", force: :cascade do |t|
    t.integer  "product_id"
    t.text     "size"
    t.integer  "quantity"
    t.integer  "quantity_sold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "colour"
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
    t.string   "contact_first_name"
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
    t.boolean  "merchant",                                       default: false
    t.boolean  "article_publisher",                              default: false
    t.boolean  "merchant_rep",                                   default: false
    t.string   "stripe_account_id"
    t.string   "stripe_customer_id"
    t.string   "contact_last_name"
    t.string   "email_for_orders"
    t.decimal  "cad_domestic_shipping",  precision: 8, scale: 2
    t.decimal  "cad_foreign_shipping",   precision: 8, scale: 2
    t.decimal  "usd_domestic_shipping",  precision: 8, scale: 2
    t.decimal  "usd_foreign_shipping",   precision: 8, scale: 2
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "default_permitted_destinations", "countries"
  add_foreign_key "default_permitted_destinations", "users"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "permitted_destinations", "countries"
  add_foreign_key "permitted_destinations", "products"
  add_foreign_key "returns", "order_units", column: "order_units_id"
  add_foreign_key "returns", "orders"
  add_foreign_key "states", "countries"
  add_foreign_key "user_feedback_answers", "user_feedbacks"
end
