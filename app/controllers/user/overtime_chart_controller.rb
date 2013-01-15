class User::OvertimeChartController < User::UserController
  
  # GET /overtime/chart
  def index
    @month_hash = month_options
    
    respond_to do |fmt|
      fmt.html { render 'index', :layout => 'chart' }
    end
  end
  
  # GET /overtime/chart/data
  def data
    month = params[:month].blank? ? '0' : params[:month]
    year = params[:year].blank? ? 0 : params[:year].to_i
    staff_id = get_staff_id
    
    criteria = Attendance
    title = 'Overtime'
    yaxis = 'Duration (hours)'
    
    criteria = criteria.where(:staff_id => staff_id)
    
    if year != 0
      criteria = criteria.where('year(work_date) = ?', year)
      title = "Overtime for Year #{year}"
    end
    
    if month != '0'
      criteria = criteria.where('month(work_date) in (?)', month)
    end
    
    list = criteria.order(:work_date).all
    months = I18n.t('date.month_names')
    
    b = Array.new(12) { |x| 0 }
    categories = Array.new(12) { |x| months[x + 1][0..2] }
    list.each do |o|
      to = o.time_out.localtime
      v = Time.new(to.year, to.month, to.day, 18, 0, 0)
      x = (to - v) / 3600.0
      m = o.work_date.month
      b[m - 1] += x
    end
    
    c = b.collect { |x| x.round(2) }
    
    @data = { :data => c, :categories => categories, :title => title, :yaxis => yaxis }
    
    render :json => @data
  end
end
