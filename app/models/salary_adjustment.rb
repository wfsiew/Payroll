# Model for salary_adjustment table.
class SalaryAdjustment < ActiveRecord::Base
  attr_accessible :id, :inc, :month, :staff_id, :year
  
  self.table_name = 'salary_adjustment'
  
  validates_presence_of :staff_id, :message => 'Staff ID is required'
  validates_presence_of :inc, :message => 'Increment is required'
  validates_presence_of :month, :message => 'Month is required'
  validates_presence_of :year, :message => 'Year is required'
  
  validates_numericality_of :inc, :greater_than => 0, 
                                  :message => 'Increment is invalid'
  validates_numericality_of :month, :greater_than => 0, :message => 'Month is invalid'
  validates_numericality_of :month, :less_than_or_equal_to => 12, 
                                    :message => 'Month is invalid'
  validates_numericality_of :year, :greater_than => 0, :message => 'Year is invalid'
                                     
  def inc
    a = read_attribute(:inc)
    a.blank? ? 0 : a
  end
end
