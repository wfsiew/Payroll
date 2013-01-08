class EmployeePayroll < ActiveRecord::Base
  attr_accessible :hourly_pay_rate, :id, :month, :total_hours, :year
  
  self.table_name = 'employee_payroll'
  
  validates_presence_of :total_hours, :message => 'Total hours is required'
  validates_presence_of :month, :message => 'Month is required'
  validates_presence_of :year, :message => 'Year is required'
  validates_presence_of :hourly_pay_rate, :message => 'Hourly pay rate is required'
  
  validates_numericality_of :total_hours, :greater_than_or_equal_to => 0, :message => 'Total hours is invalid'
  validates_numericality_of :month, :greater_than => 0, :message => 'Month is invalid'
  validates_numericality_of :month, :less_than_or_equal_to => 12, :message => 'Month is invalid'
  validates_numericality_of :year, :greater_than => 0, :message => 'Year is invalid'
  validates_numericality_of :hourly_pay_rate, :greater_than => 0, :message => 'Hourly pay rate is invalid'
end
