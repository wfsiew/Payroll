module PayslipHelper
  # Get the total deductions for one employee.
  def self.total_deductions(employee_salary)
    return 0.0 if employee_salary.blank?
    employee_salary.epf + employee_salary.socso + employee_salary.income_tax
  end
  
  # Get the total earnings for one monthly paid employee.
  def self.total_earnings(employee_salary, adjustment, total_overtime_earnings)
    return 0.0 if employee_salary.blank?
    amt = employee_salary.salary + adjustment
    amt + employee_salary.allowance + total_overtime_earnings
  end
  
  # Get the nett salary for one monthly paid employee.
  def self.nett_salary(earnings, deductions)
    earnings - deductions
  end
  
  # Get the total earnings for one hourly paid employee.
  def self.total_earnings_hourly(employee_salary, filters)
    total_hours = AttendanceHelper.get_total_hours(filters)
    rate = PayRateHelper.get_pay_rate(filters)
    
    earnings = (total_hours * rate) + employee_salary.allowance
    return earnings, total_hours, rate
  end
  
  # Get the nett salary for one hourly paid employee.
  def self.nett_salary_hourly(earnings, deductions)
    earnings - deductions
  end
  
  # Get the total overtime for a staff id in the specified year and month.
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
  
  # Get total overtime earnings for a specified year.
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
