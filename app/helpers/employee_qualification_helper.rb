module EmployeeQualificationHelper
  # Get the validation errors.
  def self.get_errors(errors)
    { :error => 1, :errors => errors }
  end
  
  # Checks whether any qualification parameters are present in the POST request.
  def self.is_empty_params?(params)
    q = params[:employee_qualification]
    if q[:level] == '0' && q[:institute].blank? && q[:major].blank? && q[:year].blank? && 
      q[:gpa].blank? && q[:start_date].blank? && q[:end_date].blank?
      return true
    end
    false
  end
  
  # Get the qualification object from the POST request.
  def self.employee_qualification_obj(o, x, params)
    q = params[:employee_qualification]
    
    _start_date = q[:start_date]
    _end_date = q[:end_date]
    
    start_date = Date.strptime(_start_date, 
      ApplicationHelper.date_fmt) if _start_date.present?
    end_date = Date.strptime(_end_date, ApplicationHelper.date_fmt) if _end_date.present?
    
    if x.blank?
      x = EmployeeQualification.new
      x.id = o.id
    end
    
    x.level = q[:level]
    x.institute = q[:institute]
    x.major = q[:major]
    x.year = q[:year]
    x.gpa = q[:gpa], 
    x.start_date = start_date
    x.end_date = end_date
    
    x
  end
  
  # Get the contact object.
  def self.find(id)
    o = nil
    begin
      o = EmployeeQualification.find(id)
      
    rescue Exception => e
      o = EmployeeQualification.new
    end
    o
  end
end
