class Employee < ActiveRecord::Base
  attr_accessible :City, :Code, :Country, :Designation, :FirstName, :ICNo, :ID, :LastName, :MiddleName, :PostalCode, :Salary, :State, :Street, :epfNo, :socso
  
  has_one :designation, :foreign_key => 'ID', :dependent => :nullify
  
  self.table_name = 'Employee'
end
