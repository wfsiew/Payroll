class Admin::PayRateController < Admin::AdminController
  
  # GET /payrate
  # GET /payrate.json
  def index
    @data = PayRateHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render 'index', :layout => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /payrate/list
  # GET /payrrate/list.json
  def list
    id = params[:id].blank? ? '' : params[:id]
    month = params[:month].blank? ? 0 : params[:month].to_i
    year = params[:year].blank? ? 0 : params[:year].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? PayRateHelper::DEFAULT_SORT_COLUMN : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? PayRateHelper::DEFAULT_SORT_DIR : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    filters = { :id => id,
                :month => month,
                :year => year }
                
    if id.blank? && month == 0 && year == 0
      @data = PayRateHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = PayRateHelper.get_filter_by(filters, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /payrate/new
  # GET /payrate/new.json
  def new
    @payrate = EmployeePayroll.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @payrate }
    end
  end
  
  # POST /payrate/create
  def create
    o = EmployeePayroll.new(:id => params[:id], :total_hours => params[:total_hours], :month => params[:month],
                            :year => params[:year], :hourly_pay_rate => params[:pay_rate])
                            
    if o.save
      render :json => { :success => 1, :message => 'Pay Rate successfully added.' }
      
    else
      render :json => PayRateHelper.get_errors(o.errors, params)
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
