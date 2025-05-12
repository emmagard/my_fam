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

ActiveRecord::Schema[8.0].define(version: 2025_05_12_163825) do
  create_table "individuals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationship_types", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inverse_type_id"
    t.index ["inverse_type_id"], name: "index_relationship_types_on_inverse_type_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "individual_id", null: false
    t.integer "relative_id", null: false
    t.integer "relationship_type_id", null: false
    t.index ["individual_id"], name: "index_relationships_on_individual_id"
    t.index ["relationship_type_id"], name: "index_relationships_on_relationship_type_id"
    t.index ["relative_id"], name: "index_relationships_on_relative_id"
  end

  add_foreign_key "relationship_types", "relationship_types", column: "inverse_type_id"
  add_foreign_key "relationships", "individuals"
  add_foreign_key "relationships", "individuals", column: "relative_id"
  add_foreign_key "relationships", "relationship_types"
end
