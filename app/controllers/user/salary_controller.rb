# This controller serves incoming requests to display out the EmployeeSalary record.
class User::SalaryController < User::UserController
  
  # Display the information.
  # GET /salary
  # GET /salary.json
  def index
    id = get_employee_id
    @employee_salary = EmployeeSalaryHelper.find(id)
    
    respond_to do |fmt|
      fmt.html
      fmt.json { render :json => @employee_salary }
    end
  end
end
