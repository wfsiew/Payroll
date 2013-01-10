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
  
  def month_options
    months = I18n.t('date.month_names')
    o = {}
    
    (1..12).each do |m|
      o[months[m]] = m
    end
    o
  end
  
  helper_method :fmt_date
  helper_method :month_name
end
