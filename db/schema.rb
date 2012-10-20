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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121020060813) do

  create_table "designation", :force => true do |t|
    t.string "title", :null => false
  end

  add_index "designation", ["title"], :name => "title", :unique => true

  create_table "employee", :force => true do |t|
    t.string  "code",           :limit => 10,                                :null => false
    t.string  "firstname",                                                   :null => false
    t.string  "middlename"
    t.string  "lastname"
    t.string  "icno",                                                        :null => false
    t.decimal "salary",                       :precision => 10, :scale => 2, :null => false
    t.string  "street",                                                      :null => false
    t.string  "city",                                                        :null => false
    t.string  "state",                                                       :null => false
    t.string  "postalcode",                                                  :null => false
    t.string  "country",                                                     :null => false
    t.integer "designation_id"
    t.string  "epfno",                                                       :null => false
    t.string  "socso",                                                       :null => false
  end

  add_index "employee", ["code"], :name => "code", :unique => true
  add_index "employee", ["designation_id"], :name => "designation"

  create_table "setting", :force => true do |t|
    t.integer "designation_id"
    t.decimal "dailyallowance", :precision => 10, :scale => 2, :null => false
    t.decimal "epf",            :precision => 10, :scale => 2, :null => false
    t.decimal "socso",          :precision => 10, :scale => 2, :null => false
    t.decimal "incometax",      :precision => 10, :scale => 2, :null => false
  end

  add_index "setting", ["designation_id"], :name => "designation", :unique => true

end
