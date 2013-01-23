# Model for employee_contact table.
class EmployeeContact < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :address_3, :city, :country, :home_phone, :id, 
                  :mobile_phone, :other_email, :postcode, :state, :work_email
  
  self.table_name = 'employee_contact'
  
  belongs_to :employee, :foreign_key => 'id'
  
  validates_presence_of :address_1, :message => 'Address 1 is required'
  validates_presence_of :city, :message => 'City is required'
  validates_presence_of :state, :message => 'State is required'
  validates_presence_of :postcode, :message => 'Postal Code is required'
  validates_presence_of :country, :message => 'Country is required'
  validates_presence_of :work_email, :message => 'Work Email is required'
end
