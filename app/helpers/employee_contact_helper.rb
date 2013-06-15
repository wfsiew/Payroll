module EmployeeContactHelper
  # Get the validation errors.
  def self.get_errors(errors)
    { :error => 1, :errors => errors }
  end
  
  # Checks whether any contact parameters are present in the POST request.
  def self.is_empty_params?(params)
    q = params[:employee_contact]
    if q[:address_1].blank? && q[:address_2].blank? && q[:address_3].blank? && 
      q[:city].blank? && q[:state].blank? && q[:postcode].blank? && q[:country].blank? && 
      q[:home_phone].blank? && q[:mobile_phone].blank? && q[:work_email].blank? && 
      q[:other_email].blank?
      return true
    end
    false
  end
  
  # Get the contact object from the POST request.
  def self.employee_contact_obj(o, x, params)
    q = params[:employee_contact]
    
    if x.blank?
      x = EmployeeContact.new
      x.id = o.id
    end
    
    x.address_1 = q[:address_1]
    x.address_2 = q[:address_2]
    x.address_3 = q[:address_3]
    x.city = q[:city]
    x.state = q[:state]
    x.postcode = q[:postcode]
    x.country = q[:country]
    x.home_phone = q[:home_phone]
    x.mobile_phone = q[:mobile_phone]
    x.work_email = q[:work_email]
    x.other_email = q[:other_email]
    
    x
  end
  
  # Get the contact object.
  def self.find(id)
    o = nil
    begin
      o = EmployeeContact.find(id)
      
    rescue Exception => e
      o = EmployeeContact.new
    end
    o
  end
end
