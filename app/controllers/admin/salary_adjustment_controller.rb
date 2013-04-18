require 'securerandom'

# This controller serves incoming requests to display out the SalaryAdjustment records.
class Admin::SalaryAdjustmentController < Admin::AdminController
  
  # GET /salaryadj
  # GET /salaryadj.json
  def index
    @data = SalaryAdjustmentHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /salaryadj/list
  # GET /salaryadj/list.json
  def list
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    month = params[:month].blank? ? 0 : params[:month].to_i
    year = params[:year].blank? ? 0 : params[:year].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? SalaryAdjustmentHelper::DEFAULT_SORT_COLUMN : 
      params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? SalaryAdjustmentHelper::DEFAULT_SORT_DIR : 
      params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    filters = { :staff_id => staff_id,
                :month => month,
                :year => year }
                
    if staff_id.blank? && month == 0 && year == 0
      @data = SalaryAdjustmentHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = SalaryAdjustmentHelper.get_filter_by(filters, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # Display the SalaryAdjustment form.
  # GET /salaryadj/new
  # GET /salaryadj/new.json
  def new
    @adj = SalaryAdjustment.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @adj }
    end
  end
  
  # Create new SalaryAdjustment record.
  # POST /salaryadj/create
  def create
    staff_id = params[:staff_id]
    
    o = SalaryAdjustment.new(:id => SecureRandom.uuid, :staff_id => params[:staff_id],
                             :inc => params[:inc], :month => params[:month], 
                             :year => params[:year])
                            
    if o.save
      render :json => { :success => 1, 
                        :message => 'Salary Adjustment successfully added.' }
      
    else
      render :json => SalaryAdjustmentHelper.get_errors(o.errors)
    end
  end
  
  # Display the SalaryAdjustment form, with existing record to edit.
  # GET /salaryadj/edit/1
  # GET /salaryadj/edit/1.json
  def edit
    @adj = SalaryAdjustment.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @adj }
    end
  end
  
  # Update SalaryAdjustment record.
  # POST /salaryadj/update
  def update
    o = SalaryAdjustment.find(params[:id])
    
    if o.update_attributes(:staff_id => params[:staff_id], :inc => params[:inc], 
                           :month => params[:month], :year => params[:year])
      render :json => { :success => 1, 
                        :message => 'Pay Rate was successfully updated.' }
      
    else
      render :json => PayRateHelper.get_errors(o.errors)
    end
  end
  
  # Delete a list of SalaryAdjustment records.
  # POST /salaryadj/delete
  def destroy
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    month = params[:month].blank? ? 0 : params[:month].to_i
    year = params[:year].blank? ? 0 : params[:year].to_i
    status = params[:status].blank? ? 0 : params[:status].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    SalaryAdjustment.delete_all(:id => ids)
    
    filters = { :staff_id => staff_id,
                :month => month,
                :year => year }
    
    if staff_id.blank? && month == 0 && year == 0
      itemscount = SalaryAdjustmentHelper.item_message(nil, pgnum, pgsize)
      
    else
      itemscount = SalaryAdjustmentHelper.item_message(filters, pgnum, pgsize)
    end
    
    render :json => { :success => 1, 
                      :itemscount => itemscount, 
                      :message => %Q{#{ids.size} salary adjustment(s) was successfully 
                                       deleted.} }
  end
end
