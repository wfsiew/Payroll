class User::JobController < User::UserController
  
  # GET /job
  # GET /job.json
  def index
    id = get_employee_id
    @employee_job = EmployeeJobHelper.find(id)
    
    respond_to do |fmt|
      fmt.html { render 'index' }
      fmt.json { render :json => @employee_job }
    end
  end
end
