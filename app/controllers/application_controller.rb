class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def fmt_date(dt)
    if dt.present?
      dt.strftime('%d-%m-%Y')
    end
  end
  
  def month_name(i)
    ApplicationHelper.month_name(i)
  end
  
  helper_method :fmt_date
  helper_method :month_name
end
