class User::UserController < ApplicationController
  layout false
  
  #before_filter :authenticate_normal_user
  
  protected
  
  def normal_user
    return unless session[:employee_id]
    @normal_user ||= session[:employee_id]
  end
  
  def authenticate_normal_user
    unless authenticate
      return false
    end
    logged_in_normal_user? ? true : access_denied
  end
  
  def logged_in_normal_user?
    normal_user.present?
  end
  
  def get_employee_id
    'c7d0cd2b-38c0-47a2-8c74-38d368653b33'
    #session[:employee_id]
  end
  
  def get_staff_id
    'S0001'
    #session[:staff_id]
  end
  
  helper_method :normal_user
  helper_method :logged_in_normal_user
end
