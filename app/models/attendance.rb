class Attendance < ActiveRecord::Base
  attr_accessible :employee_id, :id, :time_in, :time_out, :work_date
  
  self.table_name = 'attendance'
  
  belongs_to :employee, :foreign_key => 'employee_id'
  
  validates_presence_of :work_date, :message => 'Work date is required'
  validates_presence_of :time_in, :message => 'Time in is required'
  validates_presence_of :time_out, :message => 'Time out is required'
end
