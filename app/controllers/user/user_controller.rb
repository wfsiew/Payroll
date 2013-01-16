# User base controller.
# All User controllers must inherit this controller.
# User controller serves incoming requests from an authenticated Normal User.
class User::UserController < ApplicationController
  layout false
  
  # checks whether a user is authenticated before serving any request
  before_filter :authenticate_normal_user
  
  protected
  
  # Returns the employee_id.
  def normal_user
    return unless session[:employee_id]
    @normal_user ||= session[:employee_id]
  end
  
  # Checks whether a normal user is authenticated.
  def authenticate_normal_user
    unless authenticate
      return false
    end
    logged_in_normal_user? ? true : access_denied
  end
  
  # Checks whether a normal user is logged in.
  def logged_in_normal_user?
    normal_user.present?
  end
  
  # Returns the employee_id.
  def get_employee_id
    session[:employee_id]
  end
  
  # Returns the staff_id.
  def get_staff_id
    session[:staff_id]
  end
  
  helper_method :normal_user
  helper_method :logged_in_normal_user
end
