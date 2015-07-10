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

ActiveRecord::Schema.define(version: 20150710012543) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "province_manager",       limit: 255
    t.string   "agency_manager",         limit: 255
    t.string   "roles",                  limit: 255
    t.string   "qq",                     limit: 255
    t.string   "mobile",                 limit: 255
    t.string   "state",                  limit: 255
    t.string   "phone",                  limit: 255
    t.string   "address",                limit: 255
    t.string   "postcode",               limit: 255
    t.text     "remark",                 limit: 65535
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "teachers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "id_card",    limit: 255
    t.string   "province",   limit: 255
    t.string   "position",   limit: 255
    t.string   "sex",        limit: 255
    t.text     "remark",     limit: 65535
    t.string   "address",    limit: 255
    t.string   "mobile",     limit: 255
    t.string   "phone",      limit: 255
    t.string   "qq",         limit: 255
    t.string   "email",      limit: 255
    t.string   "postcode",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "training_course_teachers", force: :cascade do |t|
    t.integer  "training_course_id", limit: 4
    t.integer  "teacher_id",         limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "training_course_teachers", ["teacher_id"], name: "index_training_course_teachers_on_teacher_id", using: :btree
  add_index "training_course_teachers", ["training_course_id"], name: "index_training_course_teachers_on_training_course_id", using: :btree

  create_table "training_courses", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "code",                limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "plan_number",         limit: 4
    t.string   "grade_leader",        limit: 255
    t.string   "training_agency",     limit: 255
    t.string   "training_address",    limit: 255
    t.decimal  "training_fee",                      precision: 5, scale: 2
    t.string   "state",               limit: 255
    t.text     "remark",              limit: 65535
    t.string   "info",                limit: 255
    t.string   "training_background", limit: 255
    t.string   "training_target",     limit: 255
    t.text     "training_content",    limit: 65535
    t.text     "check_method",        limit: 65535
    t.string   "project_leader",      limit: 255
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "user_training_courses", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "training_course_id", limit: 4
    t.string   "state",              limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "user_training_courses", ["training_course_id"], name: "index_user_training_courses_on_training_course_id", using: :btree
  add_index "user_training_courses", ["user_id"], name: "index_user_training_courses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",   null: false
    t.string   "encrypted_password",     limit: 255,   default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255
    t.string   "ID_number",              limit: 255
    t.boolean  "gender",                 limit: 1,     default: true
    t.date     "birth"
    t.string   "school",                 limit: 255
    t.string   "academy",                limit: 255
    t.string   "certificate",            limit: 255
    t.string   "nation",                 limit: 255
    t.string   "position_name",          limit: 255
    t.string   "position",               limit: 255
    t.string   "address",                limit: 255
    t.string   "zip_code",               limit: 255
    t.string   "telephone",              limit: 255
    t.string   "phone",                  limit: 255
    t.string   "qq_no",                  limit: 255
    t.text     "summary",                limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",                limit: 255
    t.text     "his_train",              limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "training_course_teachers", "teachers"
  add_foreign_key "training_course_teachers", "training_courses"
  add_foreign_key "user_training_courses", "training_courses"
  add_foreign_key "user_training_courses", "users"
end
