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

ActiveRecord::Schema.define(version: 20170512221711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "all_polygons", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.geometry "coordinates", limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.string   "terc",                                                   null: false
    t.integer  "unit_type",                                              null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  create_table "communes", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.geometry "coordinates", limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.string   "terc",                                                   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  create_table "counties", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.geometry "coordinates", limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.string   "terc",                                                   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  create_table "lines", force: :cascade do |t|
    t.string   "name",                                                                       null: false
    t.geometry "coordinates", limit: {:srid=>4326, :type=>"multi_line_string"},              null: false
    t.string   "road_type",                                                     default: ""
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
  end

  create_table "places", force: :cascade do |t|
    t.geography "coordinates",  limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.string    "name"
    t.string    "object_type"
    t.string    "object_class"
    t.string    "voivodeship"
    t.string    "county"
    t.string    "commune"
    t.string    "terc"
    t.datetime  "created_at",                                                            null: false
    t.datetime  "updated_at",                                                            null: false
  end

  create_table "populations", force: :cascade do |t|
    t.geometry "coordinates",  limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.integer  "total",                                                   null: false
    t.integer  "total_0_14",                                              null: false
    t.integer  "total_15_64",                                             null: false
    t.integer  "total_65",                                                null: false
    t.integer  "total_male",                                              null: false
    t.integer  "total_female",                                            null: false
    t.integer  "male_0_14",                                               null: false
    t.integer  "male_15_64",                                              null: false
    t.integer  "male_65",                                                 null: false
    t.integer  "female_0_14",                                             null: false
    t.integer  "female_15_64",                                            null: false
    t.integer  "female_65",                                               null: false
    t.float    "female_ratio",                                            null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "registration_areas", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.geometry "coordinates", limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.string   "terc",                                                   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  create_table "registration_units", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.geometry "coordinates", limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.string   "terc",                                                   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  create_table "voivodeships", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.geometry "coordinates", limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.string   "terc",                                                   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

end
