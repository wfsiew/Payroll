# Model for employee_job table.
class EmployeeJob < ActiveRecord::Base
  attr_accessible :confirm_date, :department_id, :designation_id, :employment_status_id, 
                  :id, :job_category_id, :join_date
  
  self.table_name = 'employee_job'
  
  belongs_to :employee, :foreign_key => 'id'
  belongs_to :designation
  belongs_to :department
  belongs_to :employment_status
  belongs_to :job_category
  
  validates_presence_of :designation_id, :message => 'Designation is required'
  validates_presence_of :department_id, :message => 'Department is required'
  validates_presence_of :employment_status_id, :message => 'Employment Status is required'
  validates_presence_of :job_category_id, :message => 'Job Category is required'
  validates_presence_of :join_date, :message => 'Join Date is required'
end
