# This controller serves incoming requests to display out the EmployeeContact record.
class User::ContactController < User::UserController
  
  # Display the contact.
  # GET /contact
  # GET /contact.json
  def index
    id = get_employee_id
    @employee_contact = EmployeeContactHelper.find(id)
    
    respond_to do |fmt|
      fmt.html
      fmt.json { render :json => @employee_contact }
    end
  end
  
  # Update the contact.
  # POST /contact/update
  def update
    id = get_employee_id
    oc = EmployeeContactHelper.find(id)
    
    oc_new = false
    if oc.id.blank?
      o = Employee.find(id)
      oc = EmployeeContactHelper.employee_contact_obj(o, params)
      oc_new = true
    end
    
    if oc_new
      if oc.save
        render :json => { :success => 1, 
                          :message => 'Contact Details was successfully updated.' }
        
      else
        render :json => EmployeeContactHelper.get_errors(oc.errors)
      end
      
    else
      if EmployeeContactHelper.update_obj(oc, params)
        render :json => { :success => 1, 
                          :message => 'Contact Details was successfully updated.' }
        
      else
        render :json => EmployeeContactHelper.get_errors(oc.errors)
      end
    end
  end
end
