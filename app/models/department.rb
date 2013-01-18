# Model for department table.
class Department < ActiveRecord::Base
  attr_accessible :id, :name
  
  self.table_name = 'department'
  
  validates_presence_of :name, :message => 'Name is required'
  validates_uniqueness_of :name, :message => "Department %{value} already exist"
end
