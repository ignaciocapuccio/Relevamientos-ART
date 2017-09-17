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

ActiveRecord::Schema.define(version: 20170917063219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "cap_employees", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "last_name",     null: false
    t.string   "cuil",          null: false
    t.string   "sector"
    t.integer  "cap_result_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["cap_result_id"], name: "index_cap_employees_on_cap_result_id", using: :btree
    t.index ["cuil", "cap_result_id"], name: "index_cap_employees_on_cuil_and_cap_result_id", unique: true, using: :btree
  end

  create_table "cap_results", force: :cascade do |t|
    t.string   "topic",               null: false
    t.integer  "attendees_count",     null: false
    t.string   "used_materials"
    t.string   "delivered_materials"
    t.integer  "task_id",             null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["task_id"], name: "index_cap_results_on_task_id", using: :btree
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "cuit",                           null: false
    t.string   "address",                        null: false
    t.string   "city",                           null: false
    t.string   "province",                       null: false
    t.integer  "number",                         null: false
    t.string   "activity",                       null: false
    t.string   "contract",                       null: false
    t.string   "postal_code",                    null: false
    t.integer  "surface",            default: 1, null: false
    t.integer  "workers_count",      default: 1, null: false
    t.integer  "institutions_count", default: 1, null: false
    t.integer  "phone_number",                   null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.float    "latitude",                       null: false
    t.float    "longitude",                      null: false
    t.integer  "zone_id",                        null: false
    t.string   "street",                         null: false
    t.index ["zone_id"], name: "index_institutions_on_zone_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "task_type",                null: false
    t.integer  "status",       default: 0, null: false
    t.datetime "completed_at"
    t.integer  "visit_id",                 null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["visit_id"], name: "index_tasks_on_visit_id", using: :btree
  end

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "zone_id"
    t.string   "name",                                null: false
    t.string   "last_name",                           null: false
    t.integer  "role",                   default: 0,  null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["zone_id"], name: "index_users_on_zone_id", using: :btree
  end

  create_table "visits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",         default: 0, null: false
    t.integer  "priority",       default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "institution_id"
    t.date     "to_visit_on"
    t.datetime "completed_at"
    t.string   "observations"
    t.index ["institution_id"], name: "index_visits_on_institution_id", using: :btree
    t.index ["status"], name: "index_visits_on_status", using: :btree
    t.index ["user_id"], name: "index_visits_on_user_id", using: :btree
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cap_employees", "cap_results"
  add_foreign_key "cap_results", "tasks"
  add_foreign_key "institutions", "zones"
  add_foreign_key "tasks", "visits"
  add_foreign_key "users", "zones"
  add_foreign_key "visits", "institutions"
  add_foreign_key "visits", "users"
end
