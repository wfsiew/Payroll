# This controller serves incoming requests to display Employee Total Hours Worked Chart.
class User::TotalWorkHoursChartController < User::UserController
  
  # Display the main page.
  # GET /workhours/chart
  def index
    @month_hash = month_options
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:chart] }
    end
  end
  
  # Get the total hours worked json data to be populated to the chart.
  # GET /workhours/chart/data
  def data
    month = params[:month].blank? ? '0' : params[:month]
    year = params[:year].blank? ? 0 : params[:year].to_i
    staff_id = get_staff_id
    
    title = 'Total Hours Worked'
    yaxis = 'Duration (hours)'
    
    months = I18n.t('date.month_names')
    
    b = Array.new(12) { |x| 0 }
    categories = Array.new(12) { |x| months[x + 1][0..2] }
    
    liststaff = [staff_id]
    
    if year != 0
      listyear = [year]
      title = "Total Hours Worked for #{year}"
      
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
        liststaff.each do |s|
          filters = { :year => y, :month => m, :staff_id => s }
          total_hours = AttendanceHelper.get_total_hours(filters)
          v = total_hours
          b[m - 1] += v
        end
      end
    end
    
    c = b.collect { |x| x.round(2) }
    
    @data = { :data => c, :categories => categories, :title => title, :yaxis => yaxis }
    
    render :json => @data
  end
end
