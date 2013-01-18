# This controller serves incoming requests to display out the JobCategory records.
class Admin::JobCategoryController < Admin::AdminController
  
  # List all records.
  # GET /jobcat
  # GET /jobcat.json
  def index
    @data = JobCategoryHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /jobcat/list
  # GET /jobcat/list.json
  def list
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? JobCategoryHelper::DEFAULT_SORT_COLUMN : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? JobCategoryHelper::DEFAULT_SORT_DIR : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    if keyword.blank?
      @data = JobCategoryHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = JobCategoryHelper.get_filter_by(keyword, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # Display the JobCategory form.
  # GET /jobcat/new
  # GET /jobcat/new.json
  def new
    @jobcat = JobCategory.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @jobcat }
    end
  end
  
  # Create new JobCategory record.
  # POST /jobcat/create
  def create
    o = JobCategory.new(:name => params[:name])
    
    if o.save
      render :json => { :success => 1, 
                        :message => 'Job Category was successfully added.' }
      
    else
      render :json => JobCategoryHelper.get_errors(o.errors)
    end
  end
  
  # Display the JobCategory form, with existing record to edit.
  # GET /jobcat/edit/1
  # GET /jobcat/edit/1.json
  def edit
    @jobcat = JobCategory.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @jobcat }
    end
  end
  
  # Update JobCategory record.
  # POST /jobcat/update/1
  def update
    o = JobCategory.find(params[:id])
    
    if o.update_attributes(:name => params[:name])
      render :json => { :success => 1, 
                        :message => 'Job Category was successfully updated.' }
        
    else
      render :json => JobCategoryHelper.get_errors(o.errors)
    end
  end
  
  # Delete a list of JobCategory records.
  # POST /jobcat/delete
  def destroy
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    JobCategory.delete_all(:id => ids)
    
    itemscount = JobCategoryHelper.item_message(keyword, pgnum, pgsize)
    
    render :json => { :success => 1, 
                      :itemscount => itemscount, 
                      :message => "#{ids.size} Job Categori(es) was successfully deleted." }
  end
end
