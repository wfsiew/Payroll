# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'securerandom'

Designation.delete_all
Setting.delete_all
Employee.delete_all

(1..100).each do |k|
  des = Designation.new
  des.title = "Title#{k}"
  des.save
  
  em = Employee.new
  em.id = SecureRandom.uuid
  em.code = "Code#{k}"
  em.designation_id = k
  em.firstname = "FirstName#{k}"
  em.middlename = "MiddleName#{k}"
  em.lastname = "LastName#{k}"
  em.icno = "ICNo#{k}"
  em.salary = k * 10.00
  em.epfno = "EPF_#{k}"
  em.socso = "Socso_#{k}"
  
  addr = Address.new("Street#{k}", "City#{k}", "State#{k}", "PostalCode#{k}", "Country#{k}")
  em.address = addr
  em.save
  
  set = Setting.new
  set.id = k
  set.dailyallowance = 100
  set.designation_id = des.id
  set.epf = 56
  set.incometax = 89
  set.socso = 77
  set.save
end
