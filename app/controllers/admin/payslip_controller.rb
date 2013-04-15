# This controller serves incoming requests to display out the Employee records for pay 
# slip generation.
class Admin::PayslipController < Admin::AdminController
  
  # List all records.
  # GET /payslip
  # GET /payslip.json
  def index
    @data = EmployeeHelper.get_all
    @employmentstatus = EmploymentStatus.order(:name).all
    @designation = Designation.order(:title).all
    @dept = Department.order(:name).all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /payslip/list
  # GET /payslip/list.json
  def list
    employee = params[:employee].blank? ? '' : params[:employee]
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    employment_status = params[:employment_status].blank? ? 0 : 
      params[:employment_status].to_i
    designation = params[:designation].blank? ? 0 : params[:designation].to_i
    dept = params[:dept].blank? ? 0 : params[:dept].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? EmployeeHelper::DEFAULT_SORT_COLUMN : 
      params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? EmployeeHelper::DEFAULT_SORT_DIR : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    filters = { :employee => employee,
                :staff_id => staff_id,
                :employment_status => employment_status,
                :designation => designation,
                :dept => dept }
                
    if employee.blank? && staff_id.blank? && employment_status == 0 && designation == 0 && 
      dept == 0
      @data = EmployeeHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = EmployeeHelper.get_filter_by(filters, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # Display the pay slip information.
  # GET /payslip/slip/1/1/2012
  # GET /payslip/slip/1/1/2012.json
  def payslip
    @employee = Employee.find(params[:id])
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
        fmt.html { render 'payslip_monthly' }
        fmt.json { render :json => [@employee, @total_earnings, @total_deduct, 
                                    @nett_salary] }
      end
      
    else
      # checks whether the salary type is monthly
      if @employee_salary.pay_type == 1
        filters = { :year => year, :month => _month, :staff_id => @employee.staff_id }
        @total_overtime = PayslipHelper.total_overtime(filters)
        @total_overtime_earnings = PayslipHelper.total_overtime_earnings(filters, 
          @total_overtime)
        @adjustment = SalaryAdjustmentHelper.get_salary_adjustment(filters)
        
        @total_earnings = PayslipHelper.total_earnings(@employee_salary, @adjustment, 
          @total_overtime_earnings)
        @total_deduct = PayslipHelper.total_deductions(@employee_salary)
        @nett_salary = PayslipHelper.nett_salary(@total_earnings, @total_deduct)
        
        @basic_pay = @employee_salary.salary + @adjustment
    
        respond_to do |fmt|
          fmt.html { render 'payslip_monthly' }
          fmt.json { render :json => [@employee, @total_earnings, @total_deduct, 
                                      @nett_salary, @total_overtime, 
                                      @total_overtime_earnings, @adjustment, @basic_pay] }
        end
        
      # hourly type
      else
        filters = { :year => year, :month => _month, :staff_id => @employee.staff_id }
        @total_earnings, @total_hours, @hourly_pay_rate = 
          PayslipHelper.total_earnings_hourly(@employee_salary, filters)
        @total_deduct = PayslipHelper.total_deductions(@employee_salary)
        @nett_salary = PayslipHelper.nett_salary_hourly(@total_earnings, @total_deduct)
        
        respond_to do |fmt|
          fmt.html { render 'payslip_hourly' }
          fmt.json { render :json => [@employee, @total_earnings, @total_deduct, 
                                      @nett_salary, @total_hours, @hourly_pay_rate] }
        end
      end
    end
  end
end
