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
  
  def self.total_earnings_hourly(employee_salary, filters)
    criteria = PayRate.where(:staff_id => filters[:staff_id])
    criteria = criteria.where(:year => filters[:year])
    criteria = criteria.where(:month => filters[:month])
    earnings = criteria.sum('total_hours * hourly_pay_rate')
    p earnings
    earnings
  end
  
  def self.nett_salary_hourly(employee_salary, filters)
    total_earnings_hourly(employee_salary, filters) - total_deductions(employee_salary)
  end
end
