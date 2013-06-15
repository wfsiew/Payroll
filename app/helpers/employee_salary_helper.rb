module EmployeeSalaryHelper
  # Get the validation errors
  def self.get_errors(errors)
    { :error => 1, :errors => errors }
  end
  
  # Checks whether any salary parameters are present in the POST request.
  def self.is_empty_params?(params)
    q = params[:employee_salary]
    if q[:salary].blank? && q[:allowance].blank? && q[:epf].blank? && q[:socso].blank? && 
      q[:bank_name].blank? && q[:bank_acc_no].blank? && q[:bank_acc_type].blank? && 
      q[:bank_address].blank? && q[:epf_no].blank? && q[:socso_no].blank? && 
      q[:income_tax_no].blank?
      return true

    elsif q[:salary] == '0' && q[:allowance] == '0' && q[:epf] == '0' && 
      q[:socso] == '0' && q[:bank_name].blank? && q[:bank_acc_no].blank? && 
      q[:bank_acc_type].blank? && q[:bank_address].blank? && q[:epf_no].blank? && 
      q[:socso_no].blank? && q[:income_tax_no].blank?
      return true
    end
    false
  end
  
  # Get the salary object from the POST request.
  def self.employee_salary_obj(o, x, params)
    q = params[:employee_salary]
    
    if x.blank?
      x = EmployeeSalary.new
      x.id = o.id
    end
    
    x.salary = q[:salary]
    x.allowance = q[:allowance]
    x.epf = q[:epf]
    x.socso = q[:socso]
    x.income_tax = q[:income_tax]
    x.bank_name = q[:bank_name]
    x.bank_acc_no = q[:bank_acc_no]
    x.bank_acc_type = q[:bank_acc_type]
    x.bank_address = q[:bank_address]
    x.epf_no = q[:epf_no]
    x.socso_no = q[:socso_no]
    x.income_tax_no = q[:income_tax_no]
    x.pay_type = q[:pay_type]
    
    x
  end
  
  # Get the salary object.
  def self.find(id)
    o = nil
    begin
      o = EmployeeSalary.find(id)
      
    rescue Exception => e
      o = EmployeeSalary.new
    end
    o
  end
end
