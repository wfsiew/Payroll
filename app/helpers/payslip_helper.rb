module PayslipHelper
  def self.total_deductions(employee_salary)
    return 0.0 if employee_salary.blank?
    employee_salary.epf + employee_salary.socso + employee_salary.income_tax
  end
  
  def self.total_earnings(employee_salary, total_overtime_earnings)
    return 0.0 if employee_salary.blank?
    employee_salary.salary + employee_salary.allowance + total_overtime_earnings
  end
  
  def self.nett_salary(employee_salary, total_overtime_earnings)
    total_earnings(employee_salary, total_overtime_earnings) - total_deductions(employee_salary)
  end
  
  def self.total_earnings_hourly(employee_salary, filters)
    total = PayRate.where(:staff_id => filters[:staff_id])
                   .where(:year => filters[:year])
                   .where(:month => filters[:month])
                   .sum('total_hours * hourly_pay_rate')
    total.to_f
  end
  
  def self.nett_salary_hourly(employee_salary, filters)
    total_earnings_hourly(employee_salary, filters) - total_deductions(employee_salary)
  end
  
  def self.total_overtime(filters)
    year = filters[:year]
    month = filters[:month]
    id = filters[:staff_id]
    
    list = Attendance.where(:staff_id => id)
                     .where('month(work_date) = ?', month)
                     .where('year(work_date) = ?', year).all
    
    duration = 0
    
    list.each do |o|
      to = o.time_out.localtime
      v = Time.new(to.year, to.month, to.day, 18, 0, 0)
      x = (to - v) / 3600.0
      duration += x
    end
    
    duration
  end
  
  def self.total_overtime_earnings(filters, duration)
    year = filters[:year]
    o = OvertimeRate.where(:year => year).first
    total = 0
    if o.present?
      total = (duration / o.duration) * o.pay_rate
    end
    
    total
  end
end
