# This controller serves incoming requests to display out the Designation records.
class Admin::DesignationController < Admin::AdminController
  
  # List all records.
  # GET /designation
  # GET /designation.json
  def index
    @data = DesignationHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /designation/list
  # GET /designation/list.json
  def list
    find = params[:find].blank? ? 0 : params[:find].to_i
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? DesignationHelper::DEFAULT_SORT_COLUMN 
                                            : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? DesignationHelper::DEFAULT_SORT_DIR : 
      params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    if find == 0 && keyword.blank?
      @data = DesignationHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = DesignationHelper.get_filter_by(find, keyword, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # Display the Designation form.
  # GET /designation/new
  # GET /designation/new.json
  def new
    @designation = Designation.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @designation }
    end
  end
  
  # Create new Designation record.
  # POST /designation/create
  def create
    o = Designation.new(:title => params[:title], :desc => params[:desc], 
                        :note => params[:note])
    
    if o.save
      render :json => { :success => 1, 
                        :message => 'Job Title was successfully added.' }
      
    else
      render :json => DesignationHelper.get_errors(o.errors)
    end
  end
  
  # Display the Designation form, with existing record to edit.
  # GET /designation/edit/1
  # GET /designation/edit/1.json
  def edit
    @designation = Designation.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @designation }
    end
  end
  
  # Update Designation record.
  # POST /designation/update/1
  def update
    o = Designation.find(params[:id])
    
    if o.update_attributes(:title => params[:title], :desc => params[:desc], 
                           :note => params[:note])
      render :json => { :success => 1, 
                        :message => 'Job Title was successfully updated.' }
        
    else
      render :json => DesignationHelper.get_errors(o.errors)
    end
  end
  
  # Delete a list of Designation records.
  # POST /designation/delete
  def destroy
    find = params[:find].blank? ? 0 : params[:find].to_i
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    Designation.delete_all(:id => ids)
    
    itemscount = DesignationHelper.item_message(find, keyword, pgnum, pgsize)
    
    render :json => { :success => 1, 
                      :itemscount => itemscount, 
                      :message => "#{ids.size} Job Title(s) was successfully deleted." }
  end
end
