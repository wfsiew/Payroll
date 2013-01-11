module PayslipHelper
  def self.total_deductions(employee_salary)
    return 0.0 if employee_salary.blank?
    employee_salary.epf + employee_salary.socso + employee_salary.income_tax
  end
  
  def self.total_earnings(employee_salary)
    return 0.0 if employee_salary.blank?
    employee_salary.salary + employee_salary.allowance
  end
  
  def self.nett_salary(employee_salary)
    total_earnings(employee_salary) - total_deductions(employee_salary)
  end
end
