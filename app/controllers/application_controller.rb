class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def fmt_date(dt)
    if dt.present?
      dt.strftime('%d-%m-%Y')
    end
  end
  
  def fmt_time(t)
    if t.present?
      t.localtime.strftime('%l:%M %p')
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
  
  def end_year
    2000
  end
  
  helper_method :fmt_date
  helper_method :fmt_time
  helper_method :month_name
  helper_method :end_year
end
