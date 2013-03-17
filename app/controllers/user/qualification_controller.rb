# This controller serves incoming requests to display out the EmployeeQualification record.
class User::QualificationController < User::UserController
  
  # Display the qualification.
  # GET /qualification
  # GET /qualification.json
  def index
    id = get_employee_id
    @employee_qualification = EmployeeQualificationHelper.find(id)
    
    respond_to do |fmt|
      fmt.html
      fmt.json { render :json => @employee_qualification }
    end
  end
  
  # Update the qualification.
  # POST /qualification/update
  def update
    id = get_employee_id
    oq = EmployeeQualificationHelper.find(id)
    
    oq_new = false
    if oq.id.blank?
      o = Employee.find(id)
      oq = EmployeeQualificationHelper.employee_qualification_obj(o, params)
      oq_new = true
    end
    
    if oq_new
      if oq.save
        render :json => { :success => 1, 
                          :message => 'Qualifications was successfully updated.' }
        
      else
        render :json => EmployeeQualificationHelper.get_errors(oq.errors)
      end
      
    else
      if EmployeeQualificationHelper.update_obj(oq, params)
        render :json => { :success => 1, 
                          :message => 'Qualifications was successfully updated.' }
        
      else
        render :json => EmployeeQualificationHelper.get_errors(oq.errors)
      end
    end
  end
end
