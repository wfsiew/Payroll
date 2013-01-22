# This controller serves incoming requests to display out the Attendance records.
class Admin::AttendanceController < Admin::AdminController
  
  # List all records.
  # GET /att
  # GET /att.json
  def index
    @data = AttendanceHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /att/list
  # GET /att/list.json
  def list
    _work_date = params[:work_date]
    employee = params[:employee].blank? ? '' : params[:employee]
    
    work_date = Date.strptime(_work_date, '%d-%m-%Y') if _work_date.present?
    
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? AttendanceHelper::DEFAULT_SORT_COLUMN 
                                            : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? AttendanceHelper::DEFAULT_SORT_DIR : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    filters = { :work_date => work_date,
                :employee => employee }
                
    if work_date.blank? && employee.blank?
      @data = AttendanceHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = AttendanceHelper.get_filter_by(filters, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
end
