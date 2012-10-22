class Employee < ActiveRecord::Base
  attr_accessible :id, :code, :firstname, :middlename, :lastname, :icno, :salary, :designation_id, :epfno, :socso
  composed_of :address, :class_name => 'Address', :mapping => [%w(street street), %w(city city), %w(state state), 
                                                               %w(postalcode postalcode), %w(country country)]
  
  self.table_name = 'employee'
  
  validates_presence_of :code, :message => 'employee.blank.code'
  validates_presence_of :firstname, :message => 'employee.blank.firstname'
  validates_presence_of :middlename, :message => 'employee.blank.middlename'
  validates_presence_of :lastname, :message => 'employee.blank.lastname'
  validates_presence_of :icno, :message => 'employee.blank.icno'
  validates_presence_of :salary, :message => 'employee.blank.salary'
  validates_presence_of :designation_id, :message => 'employee.blank.designation'
  validates_presence_of :epfno, :message => 'employee.blank.epf'
  validates_presence_of :socso, :message => 'employee.blank.socso'
  
  validates_numericality_of :salary, :greater_than_or_equal_to => 0, :message => 'employee.invalid.salary'
  validates_uniqueness_of :code, :message => 'employee.unique.code'

  def designation
    begin
      o = Designation.find(designation_id)
      return o
    rescue ActiveRecord::RecordNotFound
    end
    nil
  end
end
