# Model for employee table.
class Employee < ActiveRecord::Base
  attr_accessible :dob, :staff_id, :user_id, :first_name, :gender, :id, :is_bumi, :last_name, 
                  :marital_status, :middle_name, :nationality, :new_ic, :old_ic, :passport_no, 
                  :place_of_birth, :race, :religion
  
  self.table_name = 'employee'
  
  has_one :employee_contact, :foreign_key => 'id'
  has_one :employee_job, :foreign_key => 'id'
  has_one :employee_salary, :foreign_key => 'id'
  has_one :employee_qualification, :foreign_key => 'id'
  has_one :employee, :foreign_key => 'id'
  has_many :attendance, :foreign_key => 'staff_id', :primary_key => 'staff_id'
  belongs_to :user
  
  validates_presence_of :staff_id, :message => 'Employee ID is required'
  validates_presence_of :first_name, :message => 'First Name is required'
  validates_presence_of :last_name, :message => 'Last Name is required'
  validates_presence_of :new_ic, :message => 'New IC No. is required'
  validates_presence_of :gender, :message => 'Gender is required'
  validates_presence_of :marital_status, :message => 'Marital Status is required'
  validates_presence_of :nationality, :message => 'Nationality is required'
  validates_presence_of :dob, :message => 'Date of Birth is required'
  validates_presence_of :place_of_birth, :message => 'Place of Birth is required'
  validates_presence_of :race, :message => 'Race is required'
  
  validates_uniqueness_of :staff_id, :message => "Employee ID %{value} already exist"
end
