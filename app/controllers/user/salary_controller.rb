# This controller serves incoming requests to display out the EmployeeSalary record.
class User::SalaryController < User::UserController
  
  # Display the information.
  # GET /salary
  # GET /salary.json
  def index
    id = get_employee_id
    @employee = Employee.find(id)
    @employee_salary = EmployeeSalaryHelper.find(id)
    @adjustment = SalaryAdjustmentHelper.get_salary_adjustment(
      :staff_id => @employee.staff_id, :year => Time.now.year)
    @basic_pay = @employee_salary.salary + @adjustment
    
    respond_to do |fmt|
      fmt.html
      fmt.json { render :json => [@employee_salary, @adjustment] }
    end
  end
end
