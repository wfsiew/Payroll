# This controller serves incoming requests to display out the EmployeeJob record.
class User::JobController < User::UserController
  
  # Display the information.
  # GET /job
  # GET /job.json
  def index
    id = get_employee_id
    @employee_job = EmployeeJobHelper.find(id)
    
    respond_to do |fmt|
      fmt.html
      fmt.json { render :json => @employee_job }
    end
  end
end
