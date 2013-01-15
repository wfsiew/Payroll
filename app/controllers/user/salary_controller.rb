class User::SalaryController < User::UserController
  
  # GET /salary
  # GET /salary.json
  def index
    id = get_employee_id
    @employee_salary = EmployeeSalaryHelper.find(id)
    
    respond_to do |fmt|
      fmt.html { render 'index' }
      fmt.json { render :json => @employee_salary }
    end
  end
end
