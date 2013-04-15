# Model for employee_salary table.
class EmployeeSalary < ActiveRecord::Base
  attr_accessible :allowance, :bank_acc_no, :bank_acc_type, :bank_address, :bank_name, 
                  :epf, :epf_no, :id, :income_tax, :income_tax_no, :salary, :socso_no, 
                  :pay_type, :socso
  
  self.table_name = 'employee_salary'
  
  belongs_to :employee, :foreign_key => 'id'
  
  validates_presence_of :salary, :message => 'Salary is required'
  validates_presence_of :bank_name, :message => 'Bank Name is required'
  validates_presence_of :bank_acc_no, :message => 'Bank Account No. is required'
  validates_presence_of :bank_acc_type, :message => 'Bank Account Type is required'
  validates_presence_of :bank_address, :message => 'Bank Address is required'
  validates_presence_of :epf_no, :message => 'EPF No. is required'
  validates_presence_of :pay_type, :message => 'Pay Type is required'
  validates_presence_of :epf, :message => 'EPF Deduction is required'
  
  validates_numericality_of :salary, :greater_than_or_equal_to => 0, 
                                     :message => 'Salary is invalid'
  validates_numericality_of :allowance, :greater_than_or_equal_to => 0, 
                                        :message => 'Allowance is invalid'
  validates_numericality_of :epf, :greater_than_or_equal_to => 0, 
                                  :message => 'EPF Deduction is invalid'
  validates_numericality_of :socso, :greater_than_or_equal_to => 0, 
                                    :message => 'SOCSO Deduction is invalid'
  validates_numericality_of :income_tax, :greater_than_or_equal_to => 0, 
                                         :message => 'Income Tax Deduction is invalid'
  
  def allowance
    a = read_attribute(:allowance)
    a.blank? ? 0 : a
  end
  
  def epf
    a = read_attribute(:epf)
    a.blank? ? 0 : a
  end
  
  def income_tax
    a = read_attribute(:income_tax)
    a.blank? ? 0 : a
  end
  
  def salary
    a = read_attribute(:salary)
    a.blank? ? 0 : a
  end
  
  def socso
    a = read_attribute(:socso)
    a.blank? ? 0 : a
  end
  
  def display_pay_type
    case self.pay_type
    when 1
      'Monthly'
    
    when 2
      'Hourly'
      
    else
      ''
    end
  end
end
