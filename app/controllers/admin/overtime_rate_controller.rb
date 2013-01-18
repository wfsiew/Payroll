# This controller serves incoming requests to display out the OvertimeRate records.
class Admin::OvertimeRateController < Admin::AdminController
  
  # GET /overtimerate
  # GET /overtimerate.json
  def index
    @data = OvertimeRateHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /overtimerate/list
  # GET /overtimerate/list.json
  def list
    year = params[:year].blank? ? 0 : params[:year].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? OvertimeRateHelper::DEFAULT_SORT_COLUMN : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? OvertimeRateHelper::DEFAULT_SORT_DIR : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    filters = { :year => year }
                
    if year == 0
      @data = OvertimeRateHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = OvertimeRateHelper.get_filter_by(filters, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # Display the OvertimeRate form.
  # GET /overtimerate/new
  # GET /overtimerate/new.json
  def new
    @rate = OvertimeRate.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @rate }
    end
  end
  
  # Create new OvertimeRate record.
  # POST /overtimerate/create
  def create
    o = OvertimeRate.new(:duration => params[:duration], :year => params[:year], :pay_rate => params[:pay_rate])
                            
    if o.save
      render :json => { :success => 1, 
                        :message => 'Overtime Rate successfully added.' }
      
    else
      render :json => OvertimeRateHelper.get_errors(o.errors)
    end
  end
  
  # Display the OvertimeRate form, with existing record to edit.
  # GET /overtimerate/edit/1
  # GET /overtimerate/edit/1.json
  def edit
    @rate = OvertimeRate.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @rate }
    end
  end
  
  # Update OvertimeRate record.
  # POST /overtimerate/update
  def update
    o = OvertimeRate.find(params[:id])
    
    if o.update_attributes(:duration => params[:duration], :year => params[:year], :pay_rate => params[:pay_rate])
      render :json => { :success => 1, 
                        :message => 'Pay Rate was successfully updated.' }
      
    else
      render :json => OvertimeRateHelper.get_errors(o.errors)
    end
  end
  
  # Delete a list of OvertimeRate records.
  # POST /overtimerate/delete
  def destroy
    year = params[:year].blank? ? 0 : params[:year].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    OvertimeRate.delete_all(:id => ids)
    
    filters = { :year => year }
    
    if year == 0
      itemscount = OvertimeRateHelper.item_message(nil, pgnum, pgsize)
      
    else
      itemscount = OvertimeRateHelper.item_message(filters, pgnum, pgsize)
    end
    
    render :json => { :success => 1, 
                      :itemscount => itemscount, 
                      :message => "#{ids.size} Overtime rate(s) was successfully deleted." }
  end
end
