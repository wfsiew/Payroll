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

ActiveRecord::Schema.define(:version => 20121019011714) do

  create_table "designation", :primary_key => "ID", :force => true do |t|
    t.string "Title", :null => false
  end

  add_index "designation", ["Title"], :name => "Title", :unique => true

  create_table "employee", :primary_key => "ID", :force => true do |t|
    t.string  "Code",        :limit => 10,                                :null => false
    t.string  "FirstName",                                                :null => false
    t.string  "MiddleName"
    t.string  "LastName"
    t.string  "ICNo",                                                     :null => false
    t.decimal "Salary",                    :precision => 10, :scale => 2, :null => false
    t.string  "Street",                                                   :null => false
    t.string  "City",                                                     :null => false
    t.string  "State",                                                    :null => false
    t.string  "PostalCode",                                               :null => false
    t.string  "Country",                                                  :null => false
    t.integer "Designation"
    t.string  "epfNo",                                                    :null => false
    t.string  "socso",                                                    :null => false
  end

  add_index "employee", ["Code"], :name => "Code", :unique => true
  add_index "employee", ["Designation"], :name => "Designation"

end
