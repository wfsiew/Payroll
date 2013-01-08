class EmployeeQualification < ActiveRecord::Base
  attr_accessible :end_date, :gpa, :id, :institute, :level, :major, :start_date, :year
  
  self.table_name = 'employee_qualification'
  
  belongs_to :employee, :foreign_key => 'id'
  
  validates_presence_of :level, :message => 'Qualification Level is required'
  validates_presence_of :institute, :message => 'Institute name is required'
  validates_presence_of :year, :message => 'Year obtained is required'
  validates_presence_of :start_date, :message => 'Start Date is required'
  validates_presence_of :end_date, :message => 'End Date is required'
end
