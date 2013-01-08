class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def fmt_date(dt)
    if dt.present?
      dt.strftime('%d-%m-%Y')
    end
  end
  
  helper_method :fmt_date
end
