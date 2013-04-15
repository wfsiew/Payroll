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
  def self.employee_qualification_obj(o, params)
    q = params[:employee_qualification]
    
    _start_date = q[:start_date]
    _end_date = q[:end_date]
    
    start_date = Date.strptime(_start_date, 
      ApplicationHelper.date_fmt) if _start_date.present?
    end_date = Date.strptime(_end_date, ApplicationHelper.date_fmt) if _end_date.present?
    
    EmployeeQualification.new(:id => o.id, :level => q[:level], 
                              :institute => q[:institute], :major => q[:major], 
                              :year => q[:year], :gpa => q[:gpa], 
                              :start_date => start_date, :end_date => end_date)
  end
  
  # Update the qualification object.
  def self.update_obj(o, params)
    q = params[:employee_qualification]
    
    _start_date = q[:start_date]
    _end_date = q[:end_date]
    
    start_date = Date.strptime(_start_date, 
      ApplicationHelper.date_fmt) if _start_date.present?
    end_date = Date.strptime(_end_date, ApplicationHelper.date_fmt) if _end_date.present?
    
    o.update_attributes(:level => q[:level], :institute => q[:institute], 
                        :major => q[:major], :year => q[:year], :gpa => q[:gpa], 
                        :start_date => start_date, :end_date => end_date)
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
