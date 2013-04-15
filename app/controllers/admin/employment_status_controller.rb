# This controller serves incoming requests to display out the EmploymentStatus records.
class Admin::EmploymentStatusController < Admin::AdminController
  
  # List all records.
  # GET /empstatus
  # GET /empstatus.json
  def index
    @data = EmploymentStatusHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /empstatus/list
  # GET /empstatus/list.json
  def list
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? EmploymentStatusHelper::DEFAULT_SORT_COLUMN 
                                            : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? EmploymentStatusHelper::DEFAULT_SORT_DIR 
                                      : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    if keyword.blank?
      @data = EmploymentStatusHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = EmploymentStatusHelper.get_filter_by(keyword, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # Display the EmploymentStatus form.
  # GET /empstatus/new
  # GET /empstatus/new.json
  def new
    @empstatus = EmploymentStatus.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @empstatus }
    end
  end
  
  # Create new EmploymentStatus record.
  # POST /empstatus/create
  def create
    o = EmploymentStatus.new(:name => params[:name])
    
    if o.save
      render :json => { :success => 1, 
                        :message => 'Employment Status was successfully added.' }
      
    else
      render :json => EmploymentStatusHelper.get_errors(o.errors)
    end
  end
  
  # Display the EmploymentStatus form, with existing record to edit.
  # GET /empstatus/edit/1
  # GET /empstatus/edit/1.json
  def edit
    @empstatus = EmploymentStatus.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @empstatus }
    end
  end
  
  # Update EmploymentStatus record.
  # POST /empstatus/update/1
  def update
    o = EmploymentStatus.find(params[:id])
    
    if o.update_attributes(:name => params[:name])
      render :json => { :success => 1, 
                        :message => 'Employment Status was successfully updated.' }
        
    else
      render :json => EmploymentStatusHelper.get_errors(o.errors)
    end
  end
  
  # Delete a list of EmploymentStatus records.
  # POST /empstatus/delete
  def destroy
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    EmploymentStatus.delete_all(:id => ids)
    
    itemscount = EmploymentStatusHelper.item_message(keyword, pgnum, pgsize)
    
    render :json => { :success => 1, 
                      :itemscount => itemscount, 
                      :message => %Q{#{ids.size} Employment Status(es) was successfully 
                                       deleted.} }
  end
end
