class Setting < ActiveRecord::Base
  attr_accessible :id, :designation_id, :dailyallowance, :epf, :socso, :incometax
  
  belongs_to :designation
  
  self.table_name = 'setting'
  
  validates_presence_of :dailyallowance, :message => 'setting.blank.dailyallowance'
  validates_presence_of :epf, :message => 'setting.blank.epf'
  validates_presence_of :socso, :message => 'setting.blank.socso'
  validates_presence_of :incometax, :message => 'setting.blank.incometax'
  
  validates_numericality_of :dailyallowance, :greater_than_or_equal_to => 0, :message => 'setting.invalid.dailyallowance'
  validates_numericality_of :epf, :greater_than_or_equal_to => 0, :message => 'setting.invalid.epf'
  validates_numericality_of :socso, :greater_than_or_equal_to => 0, :message => 'setting.invalid.socso'
  validates_numericality_of :incometax, :greater_than_or_equal_to => 0, :message => 'setting.invalid.incometax'
  
  validates_uniqueness_of :designation_id, :message => 'setting.unique.designation'
end
