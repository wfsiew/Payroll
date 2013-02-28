# The main application's controller.
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  LAYOUT = {
    :admin => 'admin',
    :chart => 'chart',
    :list => 'list',
    :user => 'user'
  }
  
  # Authenticates a user.
  def create
    user = User.authenticate(params[:username], params[:password])
    if user.present?
      session[:user_id] = user.id
      if user.role == User::ADMIN
        redirect_to admin_index_path and return
        
      else
        employee = user.employee
        if employee.present?
          session[:employee_id] = employee.id
          session[:staff_id] = employee.staff_id
          session[:supervisor_id] = employee.id
          redirect_to user_index_path and return
          
        else
          flash.now[:alert] = 'No employee record found. Please contact the administrator to create your employee record.'
        end
      end
      
    else
      flash.now[:alert] = 'Incorrect username or password'
    end
    
    render :action => 'new'
  end
  
  # Logs out a user.
  def destroy
    reset_session
    redirect_to login_path
  end
  
  protected
  
  # Returns the current user's user_id.
  def current_user
    return unless session[:user_id]
    @current_user ||= session[:user_id]
  end
  
  # Checks whether a user is authenticated.
  def authenticate
    logged_in? ? true : access_denied
  end
  
  # Checks whether a user is logged in.
  def logged_in?
    current_user.present?
  end
  
  # Prevents a user from accessing the system without logging in.
  def access_denied
    redirect_to login_path, :notice => 'Please log in to continue' and return false
  end
  
  # Formats a date into dd-mm-yyyy .
  # Helper method.
  def fmt_date(dt)
    if dt.present?
      dt.strftime('%d-%m-%Y')
    end
  end
  
  # Formats a time into hh:mm:ss AM/PM .
  # Helper method.
  def fmt_time(t)
    if t.present?
      t.in_time_zone('Kuala Lumpur').strftime('%l:%M %p')
    end
  end
  
  # Returns the month name from a given number.
  # Helper method.
  def month_name(i)
    ApplicationHelper.month_name(i)
  end
  
  # Returns a hash of month names.
  def month_options
    months = I18n.t('date.month_names')
    o = {}
    
    (1..12).each do |m|
      o[months[m]] = m
    end
    o
  end
  
  # Returns the end year for year selection in view.
  # Helper method.
  def end_year
    2000
  end
  
  # Returns the user_id.
  def get_user_id
    session[:user_id]
  end
  
  helper_method :current_user
  helper_method :logged_in
  helper_method :fmt_date
  helper_method :fmt_time
  helper_method :month_name
  helper_method :end_year
end
