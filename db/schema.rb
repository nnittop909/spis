# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_12_003211) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "attendee_id", null: false
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.integer "attendee_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendee_id"], name: "index_attendances_on_attendee_id"
    t.index ["eventable_type", "eventable_id"], name: "index_attendances_on_eventable"
  end

  create_table "attendees", force: :cascade do |t|
    t.string "name"
    t.integer "sex"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authorships", force: :cascade do |t|
    t.string "author_type"
    t.bigint "author_id"
    t.string "authorable_type"
    t.bigint "authorable_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_authorships_on_author"
    t.index ["authorable_type", "authorable_id"], name: "index_authorships_on_authorable"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "civil_service_eligibilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "committee_events", force: :cascade do |t|
    t.bigint "committee_id"
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["committee_id"], name: "index_committee_events_on_committee_id"
    t.index ["eventable_type", "eventable_id"], name: "index_committee_events_on_eventable"
  end

  create_table "committee_members", force: :cascade do |t|
    t.integer "role"
    t.bigint "committee_id"
    t.bigint "committee_membership_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["committee_id"], name: "index_committee_members_on_committee_id"
    t.index ["committee_membership_id"], name: "index_committee_members_on_committee_membership_id"
    t.index ["member_id"], name: "index_committee_members_on_member_id"
  end

  create_table "committee_memberships", force: :cascade do |t|
    t.string "name"
    t.date "start_of_term"
    t.date "end_of_term"
    t.boolean "active"
    t.bigint "committee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["committee_id"], name: "index_committee_memberships_on_committee_id"
  end

  create_table "committee_reports", force: :cascade do |t|
    t.string "name"
    t.string "report_number"
    t.date "date"
    t.bigint "committee_id", null: false
    t.bigint "sp_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["committee_id"], name: "index_committee_reports_on_committee_id"
    t.index ["sp_session_id"], name: "index_committee_reports_on_sp_session_id"
  end

  create_table "committees", force: :cascade do |t|
    t.integer "code"
    t.string "current_name"
    t.date "current_start_of_term"
    t.date "current_end_of_term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "community_taxes", force: :cascade do |t|
    t.string "number"
    t.date "date_of_issue"
    t.string "place_of_issue"
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_community_taxes_on_member_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "documentable_type"
    t.bigint "documentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documentable_type", "documentable_id"], name: "index_documents_on_documentable"
  end

  create_table "educational_attainments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eventable_ordinances", force: :cascade do |t|
    t.bigint "ordinance_id"
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eventable_type", "eventable_id"], name: "index_eventable_ordinances_on_eventable"
    t.index ["ordinance_id"], name: "index_eventable_ordinances_on_ordinance_id"
  end

  create_table "eventable_resolutions", force: :cascade do |t|
    t.bigint "resolution_id"
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eventable_type", "eventable_id"], name: "index_eventable_resolutions_on_eventable"
    t.index ["resolution_id"], name: "index_eventable_resolutions_on_resolution_id"
  end

  create_table "hearings", force: :cascade do |t|
    t.integer "event_number"
    t.string "title"
    t.text "description"
    t.integer "event_type"
    t.date "date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lce_approvals", force: :cascade do |t|
    t.date "approved_date"
    t.date "effectivity_date"
    t.bigint "staging_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staging_id"], name: "index_lce_approvals_on_staging_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer "event_number"
    t.string "title"
    t.text "description"
    t.date "date"
    t.integer "event_type"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer "code"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "name_suffix"
    t.string "full_name"
    t.date "birthdate"
    t.string "address"
    t.string "contact_number"
    t.integer "civil_status"
    t.string "tin_number"
    t.string "gsis_number"
    t.text "other_info"
    t.bigint "civil_service_eligibility_id"
    t.bigint "educational_attainment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["civil_service_eligibility_id"], name: "index_members_on_civil_service_eligibility_id"
    t.index ["educational_attainment_id"], name: "index_members_on_educational_attainment_id"
  end

  create_table "minutes", force: :cascade do |t|
    t.date "date"
    t.string "title"
    t.integer "minute_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "municipal_ordinances", force: :cascade do |t|
    t.string "number"
    t.string "year_and_number"
    t.string "keyword"
    t.integer "year_series"
    t.date "date_approved"
    t.bigint "resolution_id"
    t.bigint "municipality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["municipality_id"], name: "index_municipal_ordinances_on_municipality_id"
    t.index ["resolution_id"], name: "index_municipal_ordinances_on_resolution_id"
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ordinances", force: :cascade do |t|
    t.integer "code"
    t.string "number"
    t.string "title"
    t.date "date"
    t.text "remarks"
    t.integer "current_stage"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_approved"
    t.index ["category_id"], name: "index_ordinances_on_category_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "political_parties", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "alias_name"
  end

  create_table "resolutions", force: :cascade do |t|
    t.integer "code"
    t.string "number"
    t.string "title"
    t.date "date"
    t.text "remarks"
    t.integer "current_stage"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_approved"
    t.index ["category_id"], name: "index_resolutions_on_category_id"
  end

  create_table "salary_adjustments", force: :cascade do |t|
    t.date "dated_at"
    t.date "effectivity_date"
    t.decimal "monthly_salary", precision: 8, scale: 2
    t.decimal "adjustment", precision: 8, scale: 2
    t.decimal "adjusted_salary", precision: 8, scale: 2
    t.bigint "member_id", null: false
    t.bigint "term_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_salary_adjustments_on_member_id"
    t.index ["term_id"], name: "index_salary_adjustments_on_term_id"
  end

  create_table "sp_sessions", force: :cascade do |t|
    t.integer "event_number"
    t.string "title"
    t.text "description"
    t.date "date"
    t.integer "event_type"
    t.string "start_time"
    t.string "end_time"
    t.string "agenda"
    t.text "remarks"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sp_terms", force: :cascade do |t|
    t.integer "ordinal_number"
    t.date "start_of_term"
    t.date "end_of_term"
    t.bigint "office_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_sp_terms_on_office_id"
  end

  create_table "sponsorships", force: :cascade do |t|
    t.string "sponsor_type"
    t.bigint "sponsor_id"
    t.string "sponsorable_type"
    t.bigint "sponsorable_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sponsor_type", "sponsor_id"], name: "index_sponsorships_on_sponsor"
    t.index ["sponsorable_type", "sponsorable_id"], name: "index_sponsorships_on_sponsorable"
  end

  create_table "stages", force: :cascade do |t|
    t.string "name"
    t.string "alias_name"
    t.integer "phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stagings", force: :cascade do |t|
    t.date "date"
    t.date "effectivity_date"
    t.boolean "current_stage", default: false
    t.bigint "stage_id"
    t.string "stageable_type"
    t.bigint "stageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stage_id"], name: "index_stagings_on_stage_id"
    t.index ["stageable_type", "stageable_id"], name: "index_stagings_on_stageable"
  end

  create_table "step_increments", force: :cascade do |t|
    t.date "dated_at"
    t.date "effectivity_date"
    t.decimal "salary_prior_to_adjustment", precision: 8, scale: 2
    t.decimal "salary_adjustment", precision: 8, scale: 2
    t.decimal "adjusted_salary", precision: 8, scale: 2
    t.bigint "member_id", null: false
    t.bigint "term_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_step_increments_on_member_id"
    t.index ["term_id"], name: "index_step_increments_on_term_id"
  end

  create_table "terms", force: :cascade do |t|
    t.integer "sm_code"
    t.date "start_of_term"
    t.date "end_of_term"
    t.integer "appointment_status"
    t.string "termable_type"
    t.bigint "termable_id"
    t.bigint "position_id"
    t.bigint "political_party_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "interim"
    t.index ["political_party_id"], name: "index_terms_on_political_party_id"
    t.index ["position_id"], name: "index_terms_on_position_id"
    t.index ["termable_type", "termable_id"], name: "index_terms_on_termable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "username"
    t.integer "role"
    t.bigint "office_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["office_id"], name: "index_users_on_office_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vetoed_items", force: :cascade do |t|
    t.string "name"
    t.bigint "staging_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staging_id"], name: "index_vetoed_items_on_staging_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attendances", "attendees"
  add_foreign_key "committee_events", "committees"
  add_foreign_key "committee_members", "committee_memberships"
  add_foreign_key "committee_members", "committees"
  add_foreign_key "committee_members", "members"
  add_foreign_key "committee_memberships", "committees"
  add_foreign_key "committee_reports", "committees"
  add_foreign_key "committee_reports", "sp_sessions"
  add_foreign_key "community_taxes", "members"
  add_foreign_key "eventable_ordinances", "ordinances"
  add_foreign_key "eventable_resolutions", "resolutions"
  add_foreign_key "lce_approvals", "stagings"
  add_foreign_key "members", "civil_service_eligibilities"
  add_foreign_key "members", "educational_attainments"
  add_foreign_key "municipal_ordinances", "municipalities"
  add_foreign_key "municipal_ordinances", "resolutions"
  add_foreign_key "ordinances", "categories"
  add_foreign_key "resolutions", "categories"
  add_foreign_key "salary_adjustments", "members"
  add_foreign_key "salary_adjustments", "terms"
  add_foreign_key "sp_terms", "offices"
  add_foreign_key "stagings", "stages"
  add_foreign_key "step_increments", "members"
  add_foreign_key "step_increments", "terms"
  add_foreign_key "terms", "political_parties"
  add_foreign_key "terms", "positions"
  add_foreign_key "vetoed_items", "stagings"
end
