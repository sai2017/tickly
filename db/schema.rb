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

ActiveRecord::Schema.define(version: 2020_04_20_032345) do

  create_table "communication_method_people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "communication_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "person_id", null: false
    t.index ["communication_method_id"], name: "index_communication_method_people_on_communication_method_id"
    t.index ["person_id"], name: "index_communication_method_people_on_person_id"
  end

  create_table "communication_methods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "job_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "job_category_people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "job_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "person_id", null: false
    t.index ["job_category_id"], name: "index_job_category_people_on_job_category_id"
    t.index ["person_id"], name: "index_job_category_people_on_person_id"
  end

  create_table "like_points", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "balance", default: 0, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_like_points_on_user_id"
  end

  create_table "mail_notification_settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.boolean "message_flag", default: true, null: false
    t.boolean "like_flag", default: true, null: false
    t.boolean "matching_flag", default: true, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_mail_notification_settings_on_user_id"
  end

  create_table "message_room_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "message_room_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "message_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "message_room_id", null: false
    t.integer "user_id", null: false
    t.string "content", null: false
    t.boolean "unread", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "prefectures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", limit: 100
    t.date "birthday"
    t.string "company_name", limit: 50
    t.text "self_introduction"
    t.string "img_name"
    t.string "occupation", limit: 50
    t.string "catch_copy", limit: 50
    t.text "original_experience"
    t.text "purpose_of_working"
    t.text "weakness"
    t.text "want_to_do"
    t.text "want_to_connect"
    t.bigint "person_id", null: false
    t.bigint "prefecture_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_profiles_on_person_id"
    t.index ["prefecture_id"], name: "index_profiles_on_prefecture_id"
  end

  create_table "purpose_of_use_people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "purpose_of_use_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "person_id", null: false
    t.index ["person_id"], name: "index_purpose_of_use_people_on_person_id"
    t.index ["purpose_of_use_id"], name: "index_purpose_of_use_people_on_purpose_of_use_id"
  end

  create_table "purpose_of_uses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.boolean "new_arrival_flag", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follower_id", "following_id"], name: "index_relationships_on_follower_id_and_following_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
    t.index ["following_id"], name: "index_relationships_on_following_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
    t.string "provider"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "communication_method_people", "communication_methods"
  add_foreign_key "communication_method_people", "people"
  add_foreign_key "job_category_people", "job_categories"
  add_foreign_key "job_category_people", "people"
  add_foreign_key "like_points", "users"
  add_foreign_key "mail_notification_settings", "users"
  add_foreign_key "people", "users"
  add_foreign_key "profiles", "people"
  add_foreign_key "profiles", "prefectures"
  add_foreign_key "purpose_of_use_people", "people"
  add_foreign_key "purpose_of_use_people", "purpose_of_uses"
end
