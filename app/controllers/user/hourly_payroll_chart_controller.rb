# This controller serves incoming requests to display Hourly Payroll Chart.
class User::HourlyPayrollChartController < User::UserController
  
  # Display the main page.
  # GET /hourly/chart
  def index
    @month_hash = month_options
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:chart] }
    end
  end
  
  # Get the hourly payroll json data to be populated to the chart.
  # POST /hourly/chart/data
  def data
    month = params[:month].blank? ? '0' : params[:month]
    year = params[:year].blank? ? 0 : params[:year].to_i
    staff_id = get_staff_id
    
    title = 'Hourly Payroll'
    yaxis = 'Total Amount (RM)'
    
    months = I18n.t('date.month_names')
    
    o = Array.new(12) { |x| [months[x + 1], 0] }
    b = Array.new(12) { |x| 0 }
    categories = Array.new(12) { |x| months[x + 1][0..2] }
    
    if year != 0
      listyear = [year]
      title = "Hourly Payroll for #{year}"
      
    else
      list = PayRate.select('distinct(year)').all
      listyear = list.collect { |x| x.year }
    end
    
    if month != '0'
      listmonth = month.collect { |x| x.to_i }
      
    else
      list = PayRate.select('distinct(month)').all
      listmonth = list.collect { |x| x.month }
    end
    
    listyear.each do |y|
      listmonth.each do |m|
        filters = { :year => y, :month => m, :staff_id => staff_id }
        total_hours = AttendanceHelper.get_total_hours(filters)
        rate = PayRateHelper.get_pay_rate(filters)
        v = total_hours * rate
        o[m - 1][1] = v
        b[m - 1] += v
      end
    end
    
    c = b.collect { |x| x.round(2) }
    
    @data = { :pie => o, :column => { :data => c, 
                                      :categories => categories, 
                                      :yaxis => yaxis }, 
                                      :title => title }
    
    render :json => @data
  end
end
