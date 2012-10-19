class Designation < ActiveRecord::Base
  attr_accessible :ID, :Title
  
  belongs_to :employee
  
  self.table_name = 'Designation'
end
