class User::ContactController < User::UserController
  
  # GET /contact
  # GET /contact.json
  def index
    id = get_employee_id
    @employee_contact = EmployeeContactHelper.find(id)
    
    respond_to do |fmt|
      fmt.html { render 'index' }
      fmt.json { render :json => @employee_contact }
    end
  end
  
  # POST /contact/update
  def update
    id = get_employee_id
    oc = EmployeeContactHelper.find(id)
    
    oc_new = false
    if oc.blank?
      o = Employee.find(id)
      oc = EmployeeContactHelper.employee_contact_obj(o, params)
      oc_new = true
    end
    
    if oc_new
      if oc.save
        render :json => { :success => 1, :message => 'Contact Details was successfully updated.' }
        
      else
        render :json => EmployeeContactHelper.get_errors(oc.errors, params)
      end
      
    else
      if EmployeeContactHelper.update_obj(oc, params)
        render :json => { :success => 1, :message => 'Contact Details was successfully updated.' }
        
      else
        render :json => EmployeeContactHelper.get_errors(oc.errors, params)
      end
    end
  end
end
