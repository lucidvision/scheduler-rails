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

ActiveRecord::Schema.define(version: 20160525194227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auditions", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title"
    t.string   "actor"
    t.string   "role"
    t.string   "phone"
    t.string   "date"
    t.string   "time"
    t.string   "status"
    t.string   "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "auditions", ["project_id"], name: "index_auditions_on_project_id", using: :btree
  add_index "auditions", ["user_id"], name: "index_auditions_on_user_id", using: :btree

  create_table "histories", force: :cascade do |t|
    t.integer  "audition_id"
    t.string   "action"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "histories", ["audition_id"], name: "index_histories_on_audition_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "audition_id"
    t.integer  "user_id"
    t.text     "body",        default: ""
    t.boolean  "read",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "messages", ["audition_id"], name: "index_messages_on_audition_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "director"
    t.string   "phone"
    t.string   "roles",                   array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "rails_push_notifications_apns_apps", force: :cascade do |t|
    t.text     "apns_dev_cert"
    t.text     "apns_prod_cert"
    t.boolean  "sandbox_mode"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "rails_push_notifications_gcm_apps", force: :cascade do |t|
    t.string   "gcm_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rails_push_notifications_mpns_apps", force: :cascade do |t|
    t.text     "cert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rails_push_notifications_notifications", force: :cascade do |t|
    t.text     "destinations"
    t.integer  "app_id"
    t.string   "app_type"
    t.text     "data"
    t.text     "results"
    t.integer  "success"
    t.integer  "failed"
    t.boolean  "sent",         default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "rails_push_notifications_notifications", ["app_id", "app_type", "sent"], name: "app_and_sent_index_on_rails_push_notifications", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name",                   default: ""
    t.string   "role",                   default: "", null: false
    t.string   "auth_token",             default: ""
    t.string   "platform",               default: ""
    t.string   "notification_token",     default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
