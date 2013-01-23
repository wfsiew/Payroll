# Model for overtime_rate table.
class OvertimeRate < ActiveRecord::Base
  attr_accessible :duration, :pay_rate, :year
  
  self.table_name = 'overtime_rate'
  
  validates_presence_of :duration, :message => 'Duration is required'
  validates_presence_of :year, :message => 'Year is required'
  validates_presence_of :pay_rate, :message => 'Pay Rate is required'
  
  validates_numericality_of :duration, :greater_than_or_equal_to => 0, :message => 'Duration is invalid'
  validates_numericality_of :year, :greater_than => 0, :message => 'Year is invalid'
  validates_numericality_of :pay_rate, :greater_than => 0, :message => 'Pay Rate is invalid'
  
  validates_uniqueness_of :year, :message => "Overtime rate for year %{value} already exist"
  
  def duration
    a = read_attribute(:duration)
    a.blank? ? 0 : a
  end
  
  def pay_rate
    a = read_attribute(:pay_rate)
    a.blank? ? 0 : a
  end
end
