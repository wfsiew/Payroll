class Designation < ActiveRecord::Base
  attr_accessible :id, :title
  
  has_one :setting
  belongs_to :employee
  
  self.table_name = 'designation'
  
  validates_presence_of :title, :message => 'designation.blank.title'
end
