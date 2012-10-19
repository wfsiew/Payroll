# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..100).each do |k|
  des = Designation.new
  des.ID = k
  des.Title = "Title#{k}"
  des.save
  
  em = Employee.new
  em.ID = "ID_#{k}"
  em.City = "City#{k}"
  em.Code = "Code#{k}"
  em.Country = "Country#{k}"
  em.Designation = des.ID
  em.FirstName = "FirstName#{k}"
  em.ICNo = "ICNo#{k}"
  em.LastName = "LastName#{k}"
  em.MiddleName = "MiddleName#{k}"
  em.PostalCode = "PostalCode#{k}"
  em.Salary = k * 10.00
  em.State = "State#{k}"
  em.Street = "Street#{k}"
  em.epfNo = "EPF_#{k}"
  em.socso = "Socso_#{k}"
  em.Code = "Code#{k}"
  em.save
end
