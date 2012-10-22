class DesignationController < ApplicationController
  layout false
  
  def index
    @data = DesignationHelper.get_all(1, ApplicationHelper::Pager.default_page_size)
    
    respond_to do |fmt|
      fmt.html { render 'index', :layout => 'list' }
    end
  end
  
  def list
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    
    if keyword.blank?
      @data = DesignationHelper.get_all(pgnum, pgsize)
      
    else
      @data = DesignationHelper.get_filter_by(keyword, pgnum, pgsize)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
    end
  end
  
  def new
    @designation = Designation.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
    end
  end
  
  def create
    o = Designation.new(:title => params[:title])
    
    respond_to do |fmt|
      if o.save
        fmt.json { render :json => { :success => 1 } }
        
      else
        fmt.json { render :json => DesignationHelper.get_errors(o.errors, params) }
      end
    end
  end
  
  def edit
    @designation = Designation.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
    end
  end
  
  def update
    o = Designation.find(params[:id])
    
    respond_to do |fmt|
      if o.update_attributes(:title => params[:title])
        fmt.json { render :json => { :success => 1 } }
        
      else
        fmt.json { render :json => DesignationHelper.get_errors(o.errors, params) }
      end
    end
  end
  
  def destroy
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    lsid = ids.split(',')
    Designation.delete_all(:id => lsid)
    
    itemscount = DesignationHelper.item_message(keyword, pgnum, pgsize)
    
    respond_to do |fmt|
      fmt.json { render :json => { :success => 1, :itemscount => itemscount } }
    end
  end
end
