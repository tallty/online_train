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

ActiveRecord::Schema.define(version: 20160316085239) do

  create_table "activities", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "content",     limit: 65535
    t.string   "picture_url", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "admin_user_tasks", force: :cascade do |t|
    t.integer  "admin_id",     limit: 4
    t.integer  "user_task_id", limit: 4
    t.decimal  "score",                      precision: 5, scale: 2
    t.text     "comment",      limit: 65535
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "admin_user_tasks", ["admin_id"], name: "index_admin_user_tasks_on_admin_id", using: :btree
  add_index "admin_user_tasks", ["user_task_id"], name: "index_admin_user_tasks_on_user_task_id", using: :btree

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
    t.integer  "role",                   limit: 4
    t.string   "qq",                     limit: 255
    t.string   "mobile",                 limit: 255
    t.string   "state",                  limit: 255
    t.string   "phone",                  limit: 255
    t.string   "address",                limit: 255
    t.string   "postcode",               limit: 255
    t.text     "remark",                 limit: 65535
    t.string   "username",               limit: 255
    t.integer  "adminable_id",           limit: 4
    t.string   "adminable_type",         limit: 255
    t.integer  "school_id",              limit: 4
  end

  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["username"], name: "index_admins_on_username", unique: true, using: :btree

  create_table "appraises", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "teacher_id",         limit: 4
    t.text     "remark",             limit: 65535
    t.string   "degree",             limit: 255
    t.integer  "training_course_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "appraises", ["teacher_id"], name: "index_appraises_on_teacher_id", using: :btree
  add_index "appraises", ["training_course_id"], name: "index_appraises_on_training_course_id", using: :btree
  add_index "appraises", ["user_id"], name: "index_appraises_on_user_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "attachmentable_id",   limit: 4
    t.string   "attachmentable_type", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "attachments", ["attachmentable_id", "attachmentable_type"], name: "index_attachments_on_attachmentable_id_and_attachmentable_type", unique: true, using: :btree

  create_table "course_resources", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "remark",             limit: 65535
    t.integer  "training_course_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "course_resources", ["training_course_id"], name: "index_course_resources_on_training_course_id", using: :btree

  create_table "divides", force: :cascade do |t|
    t.integer  "training_course_id", limit: 4
    t.string   "name",               limit: 255
    t.string   "header",             limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "divides", ["training_course_id"], name: "index_divides_on_training_course_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",                    limit: 255
    t.text     "content",                  limit: 65535
    t.integer  "classify",                 limit: 4,     default: 1
    t.string   "picture_url",              limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "picture_url_file_name",    limit: 255
    t.string   "picture_url_content_type", limit: 255
    t.integer  "picture_url_file_size",    limit: 4
    t.datetime "picture_url_updated_at"
    t.boolean  "is_competition",           limit: 1
  end

  create_table "journals", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "training_course_id", limit: 4
    t.string   "title",              limit: 255
    t.text     "content",            limit: 65535
    t.datetime "add_date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "journals", ["training_course_id"], name: "index_journals_on_training_course_id", using: :btree
  add_index "journals", ["user_id"], name: "index_journals_on_user_id", using: :btree

  create_table "manager_feedbacks", force: :cascade do |t|
    t.integer  "admin_id",            limit: 4
    t.integer  "training_course_id",  limit: 4
    t.string   "organizer",           limit: 255
    t.string   "total_hours",         limit: 255
    t.string   "total_expenses",      limit: 255
    t.text     "total_expenses_info", limit: 65535
    t.text     "feedback",            limit: 65535
    t.text     "remark",              limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "manager_feedbacks", ["admin_id"], name: "index_manager_feedbacks_on_admin_id", using: :btree
  add_index "manager_feedbacks", ["training_course_id"], name: "index_manager_feedbacks_on_training_course_id", using: :btree

  create_table "materials", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "catalog",    limit: 4
    t.string   "mdate",      limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "sub_title",  limit: 255
    t.integer  "view_count", limit: 4,     default: 0
    t.string   "author",     limit: 255
    t.text     "content",    limit: 65535
    t.string   "category",   limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "username",    limit: 255
    t.string   "name",        limit: 255
    t.integer  "province_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "student_feedbacks", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "training_course_id", limit: 4
    t.string   "teach",              limit: 255
    t.string   "discussion",         limit: 255
    t.string   "visiting",           limit: 255
    t.string   "organization",       limit: 255
    t.string   "study_life",         limit: 255
    t.text     "most_value",         limit: 65535
    t.text     "most_gain",          limit: 65535
    t.text     "graduate_message",   limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "student_feedbacks", ["training_course_id"], name: "index_student_feedbacks_on_training_course_id", using: :btree
  add_index "student_feedbacks", ["user_id"], name: "index_student_feedbacks_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "title",              limit: 255,               null: false
    t.text     "body",               limit: 65535,             null: false
    t.integer  "submit_user_count",  limit: 4,     default: 0
    t.integer  "training_course_id", limit: 4,                 null: false
    t.integer  "admin_id",           limit: 4,                 null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "tasks", ["admin_id"], name: "index_tasks_on_admin_id", using: :btree
  add_index "tasks", ["training_course_id"], name: "index_tasks_on_training_course_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "id_card",    limit: 255
    t.string   "position",   limit: 255
    t.boolean  "sex",        limit: 1,     default: true
    t.text     "remark",     limit: 65535
    t.string   "address",    limit: 255
    t.string   "mobile",     limit: 255
    t.string   "phone",      limit: 255
    t.string   "qq",         limit: 255
    t.string   "email",      limit: 255
    t.string   "postcode",   limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "school_id",  limit: 4
    t.string   "job_title",  limit: 255
  end

  create_table "todos", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.boolean  "state",      limit: 1,     default: false
    t.integer  "admin_id",   limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "todos", ["admin_id"], name: "index_todos_on_admin_id", using: :btree

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
    t.string   "training_address",    limit: 255
    t.decimal  "training_fee",                      precision: 10, scale: 2
    t.string   "state",               limit: 255
    t.text     "remark",              limit: 65535
    t.text     "info",                limit: 65535
    t.text     "training_background", limit: 65535
    t.text     "training_target",     limit: 65535
    t.text     "training_content",    limit: 65535
    t.text     "check_method",        limit: 65535
    t.string   "project_leader",      limit: 255
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
    t.string   "contact",             limit: 255
    t.integer  "school_id",           limit: 4
    t.string   "aasm_state",          limit: 255
    t.string   "category",            limit: 255
    t.string   "grade_leader",        limit: 255
    t.boolean  "be_applied",          limit: 1,                              default: false
    t.integer  "notification_id",     limit: 4
    t.datetime "start_apply_time"
    t.datetime "end_apply_time"
    t.integer  "admin_id",            limit: 4
    t.string   "linkman",             limit: 255
    t.string   "phone",               limit: 255
    t.string   "fax",                 limit: 255
    t.string   "mobile",              limit: 255
    t.string   "email",               limit: 255
    t.datetime "task_end_time"
    t.integer  "journal_number",      limit: 4
  end

  add_index "training_courses", ["admin_id"], name: "index_training_courses_on_admin_id", using: :btree
  add_index "training_courses", ["notification_id"], name: "index_training_courses_on_notification_id", using: :btree

  create_table "user_messages", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "message_id", limit: 4
    t.boolean  "status",     limit: 1, default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "user_messages", ["message_id"], name: "index_user_messages_on_message_id", using: :btree
  add_index "user_messages", ["user_id"], name: "index_user_messages_on_user_id", using: :btree

  create_table "user_tasks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "task_id",    limit: 4
    t.string   "title",      limit: 255
    t.string   "content",    limit: 255
    t.string   "appraise",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_tasks", ["task_id"], name: "index_user_tasks_on_task_id", using: :btree
  add_index "user_tasks", ["user_id"], name: "index_user_tasks_on_user_id", using: :btree

  create_table "user_training_courses", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "training_course_id", limit: 4
    t.boolean  "state",              limit: 1,   default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "remark",             limit: 255
    t.string   "certificate_no",     limit: 255
    t.integer  "divide_id",          limit: 4
    t.datetime "deleted_at"
  end

  add_index "user_training_courses", ["divide_id"], name: "index_user_training_courses_on_divide_id", using: :btree
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
    t.string   "profession",             limit: 255
    t.integer  "role",                   limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "manager_feedbacks", "admins"
  add_foreign_key "manager_feedbacks", "training_courses"
  add_foreign_key "training_course_teachers", "teachers"
  add_foreign_key "training_course_teachers", "training_courses"
  add_foreign_key "user_training_courses", "training_courses"
  add_foreign_key "user_training_courses", "users"
end
