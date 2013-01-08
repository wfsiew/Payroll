class Designation < ActiveRecord::Base
  attr_accessible :id, :title, :desc, :note
  
  self.table_name = 'designation'
  
  has_many :employee_job, :dependent => :nullify
  
  validates_presence_of :title, :message => 'Job Title is required'
  validates_uniqueness_of :title, :message => "Job Title %{value} already exist"
end
