class Admin::ChartController < Admin::AdminController
  
  def index
    respond_to do |fmt|
      fmt.html
    end
  end
  
  def data
    year = 2012
    criteria = PayRate.where(:year => year)
    total = criteria.sum('total_hours * hourly_pay_rate')
    list = criteria.order(:month).all
    
    months = I18n.t('date.month_names')
    
    o = []
    c = []
    list.each do |v|
      x = v.total_hours * v.hourly_pay_rate
      y = (x / total) * 100
      o << [months[v.month], y]
      c << x
    end
    
    @data = { :pie => o, :column => c }
    
    render :json => @data
  end
end