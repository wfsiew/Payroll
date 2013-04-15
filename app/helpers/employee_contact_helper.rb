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
  def self.employee_contact_obj(o, params)
    q = params[:employee_contact]
    
    EmployeeContact.new(:id => o.id, :address_1 => q[:address_1], 
                        :address_2 => q[:address_2], :address_3 => q[:address_3],
                        :city => q[:city], :state => q[:state], :postcode => q[:postcode], 
                        :country => q[:country], :home_phone => q[:home_phone], 
                        :mobile_phone => q[:mobile_phone], :work_email => q[:work_email],
                        :other_email => q[:other_email])
  end
  
  # Update the contact object.
  def self.update_obj(o, params)
    q = params[:employee_contact]
    
    o.update_attributes(:address_1 => q[:address_1], :address_2 => q[:address_2], 
                        :address_3 => q[:address_3], :city => q[:city], 
                        :state => q[:state], :postcode => q[:postcode], 
                        :country => q[:country], :home_phone => q[:home_phone], 
                        :mobile_phone => q[:mobile_phone], :work_email => q[:work_email],
                        :other_email => q[:other_email])
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
