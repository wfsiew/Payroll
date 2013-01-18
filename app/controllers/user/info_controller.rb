# This controller serves incoming requests to display out the Employee record.
class User::InfoController < User::UserController
  
  # Display the information.
  # GET /info
  # GET /info.json
  def index
    id = get_employee_id
    @employee = Employee.find(id)
    @user = @employee.user
    
    respond_to do |fmt|
      fmt.html
      fmt.json { render :json => @employee }
    end
  end
  
  # Update the information.
  # POST /info/update
  def update
    id = get_employee_id
    o = Employee.find(id)
    
    if EmployeeHelper.update_info(o, params)
      render :json => { :success => 1, 
                        :message => 'Personal Details was successfully updated.' }
      
    else
      render :json => EmployeeHelper.get_errors(o.errors)
    end
  end
end
