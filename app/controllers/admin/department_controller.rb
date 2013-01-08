class Admin::DepartmentController < Admin::AdminController
  
  # GET /dept
  # GET /dept.json
  def index
    @data = DepartmentHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render 'index', :layout => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /dept/list
  # GET /dept/list.json
  def list
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? DepartmentHelper::DEFAULT_SORT_COLUMN : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? DepartmentHelper::DEFAULT_SORT_DIR : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    if keyword.blank?
      @data = DepartmentHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = DepartmentHelper.get_filter_by(keyword, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /dept/new
  # GET /dept/new.json
  def new
    @dept = Department.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @dept }
    end
  end
  
  # POST /dept/create
  def create
    o = Department.new(:name => params[:name])
    
    if o.save
      render :json => { :success => 1, :message => 'Department was successfully added.' }
      
    else
      render :json => DepartmentHelper.get_errors(o.errors, params)
    end
  end
  
  # GET /dept/edit/1
  # GET /dept/edit/1.json
  def edit
    @dept = Department.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @dept }
    end
  end
  
  # POST /dept/update/1
  def update
    o = Department.find(params[:id])
    
    if o.update_attributes(:name => params[:name])
      render :json => { :success => 1, :message => 'Department was successfully updated.' }
        
    else
      render :json => DepartmentHelper.get_errors(o.errors, params)
    end
  end
  
  # POST /dept/delete
  def destroy
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    Department.delete_all(:id => ids)
    
    itemscount = DepartmentHelper.item_message(keyword, pgnum, pgsize)
    
    render :json => { :success => 1, :itemscount => itemscount, :message => "#{ids.size} Department(s) was successfully deleted." }
  end
end
