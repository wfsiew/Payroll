# Model for pay_rate table.
class PayRate < ActiveRecord::Base
  attr_accessible :hourly_pay_rate, :id, :month, :staff_id, :total_hours, :year
  
  self.table_name = 'pay_rate'
  
  validates_presence_of :staff_id, :message => 'Satff ID is required'
  validates_presence_of :total_hours, :message => 'Total hours is required'
  validates_presence_of :month, :message => 'Month is required'
  validates_presence_of :year, :message => 'Year is required'
  validates_presence_of :hourly_pay_rate, :message => 'Hourly pay rate is required'
  
  validates_numericality_of :total_hours, :greater_than_or_equal_to => 0, 
                                          :message => 'Total hours is invalid'
  validates_numericality_of :month, :greater_than => 0, :message => 'Month is invalid'
  validates_numericality_of :month, :less_than_or_equal_to => 12, 
                                    :message => 'Month is invalid'
  validates_numericality_of :year, :greater_than => 0, :message => 'Year is invalid'
  validates_numericality_of :hourly_pay_rate, :greater_than => 0, 
                                              :message => 'Hourly pay rate is invalid'
  
  def hourly_pay_rate
    a = read_attribute(:hourly_pay_rate)
    a.blank? ? 0 : a
  end
  
  def total_hours
    a = read_attribute(:total_hours)
    a.blank? ? 0 : a
  end
end
