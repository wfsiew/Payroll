# This controller serves incoming requests to display out the Employee pay slip.
class User::PayslipController < User::UserController
  
  # Display the main page.
  # GET /payslip
  def index
    respond_to do |fmt|
      fmt.html
    end
  end
  
  # Display the pay slip information.
  # GET /payslip/slip
  # GET /payslip/slip.json
  def payslip
    id = get_employee_id
    @employee = Employee.find(id)
    @employee_salary = @employee.employee_salary
    
    _month = params[:month].to_i
    month = month_name(params[:month].to_i)
    year = params[:year].blank? ? Time.now.year : params[:year].to_i
    @period = "#{month}-#{year}"
    
    if @employee_salary.blank?
      @total_earnings = 0
      @total_deduct = 0
      @nett_salary = 0
      
      @employee_salary = EmployeeSalary.new
      
      respond_to do |fmt|
        fmt.html { render 'admin/payslip/payslip_monthly' }
        fmt.json { render :json => [@employee, @total_earnings, @total_deduct, @nett_salary] }
      end
      
    else
      # checks whether the salary type is monthly
      if @employee_salary.pay_type == 1
        filters = { :year => year, :month => _month, :staff_id => @employee.staff_id }
        @total_overtime = PayslipHelper.total_overtime(filters)
        @total_overtime_earnings = PayslipHelper.total_overtime_earnings(filters, @total_overtime)
        
        @total_earnings = PayslipHelper.total_earnings(@employee_salary, @total_overtime_earnings)
        @total_deduct = PayslipHelper.total_deductions(@employee_salary)
        @nett_salary = PayslipHelper.nett_salary(@employee_salary, @total_overtime_earnings)
    
        respond_to do |fmt|
          fmt.html { render 'admin/payslip/payslip_monthly' }
          fmt.json { render :json => [@employee, @total_earnings, @total_deduct, @nett_salary, @total_overtime, @total_overtime_earnings] }
        end
        
      # hourly type
      else
        filters = { :year => year, :month => _month, :staff_id => @employee.staff_id }
        @total_earnings, @total_hours, @hourly_pay_rate = PayslipHelper.total_earnings_hourly(@employee_salary, filters)
        @total_deduct = PayslipHelper.total_deductions(@employee_salary)
        @nett_salary = PayslipHelper.nett_salary_hourly(@total_earnings, @total_deduct)
        
        respond_to do |fmt|
          fmt.html { render 'admin/payslip/payslip_hourly' }
          fmt.json { render :json => [@employee, @total_earnings, @total_deduct, @nett_salary, @total_hours, @hourly_pay_rate] }
        end
      end
    end
  end
end
