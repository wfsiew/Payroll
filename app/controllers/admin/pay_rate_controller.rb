require 'securerandom'

# This controller serves incoming requests to display out the PayRate records.
class Admin::PayRateController < Admin::AdminController
  
  # GET /payrate
  # GET /payrate.json
  def index
    @data = PayRateHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /payrate/list
  # GET /payrrate/list.json
  def list
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    month = params[:month].blank? ? 0 : params[:month].to_i
    year = params[:year].blank? ? 0 : params[:year].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? PayRateHelper::DEFAULT_SORT_COLUMN : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? PayRateHelper::DEFAULT_SORT_DIR : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    filters = { :staff_id => staff_id,
                :month => month,
                :year => year }
                
    if staff_id.blank? && month == 0 && year == 0
      @data = PayRateHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = PayRateHelper.get_filter_by(filters, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # Display the PayRate form.
  # GET /payrate/new
  # GET /payrate/new.json
  def new
    @payrate = PayRate.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @payrate }
    end
  end
  
  # Create new PayRate record.
  # POST /payrate/create
  def create
    o = PayRate.new(:id => SecureRandom.uuid, :staff_id => params[:staff_id], 
                    :month => params[:month], :year => params[:year], 
                    :hourly_pay_rate => params[:pay_rate])
                            
    if o.save
      render :json => { :success => 1, 
                        :message => 'Pay Rate successfully added.' }
      
    else
      render :json => PayRateHelper.get_errors(o.errors)
    end
  end
  
  # Display the PayRate form, with existing record to edit.
  # GET /payrate/edit/1
  # GET /payrate/edit/1.json
  def edit
    @payrate = PayRate.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @payrate }
    end
  end
  
  # Update PayRate record.
  # POST /payrate/update
  def update
    o = PayRate.find(params[:id])
    
    if o.update_attributes(:staff_id => params[:staff_id], :month => params[:month], 
                           :year => params[:year], :hourly_pay_rate => params[:pay_rate])
      render :json => { :success => 1, 
                        :message => 'Pay Rate was successfully updated.' }
      
    else
      render :json => PayRateHelper.get_errors(o.errors)
    end
  end
  
  # Delete a list of PayRate records.
  # POST /payrate/delete
  def destroy
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    month = params[:month].blank? ? 0 : params[:month].to_i
    year = params[:year].blank? ? 0 : params[:year].to_i
    status = params[:status].blank? ? 0 : params[:status].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    PayRate.delete_all(:id => ids)
    
    filters = { :staff_id => staff_id,
                :month => month,
                :year => year }
    
    if staff_id.blank? && month == 0 && year == 0
      itemscount = PayRateHelper.item_message(nil, pgnum, pgsize)
      
    else
      itemscount = PayRateHelper.item_message(filters, pgnum, pgsize)
    end
    
    render :json => { :success => 1, 
                      :itemscount => itemscount, 
                      :message => "#{ids.size} pay rate(s) was successfully deleted." }
  end
end
