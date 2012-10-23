class SettingController < ApplicationController
  layout false
  
  # GET /setting
  # GET /setting.json
  def index
    @data = SettingHelper.get_all(1, ApplicationHelper::Pager.default_page_size)
	
	  respond_to do |fmt|
	    fmt.html { render 'index', :layout => 'list' }
	    fmt.json { render :json => @data }
	  end
  end
  
  # GET /setting/list
  # GET /setting/list.json
  def list
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    
    if keyword.blank?
      @data = SettingHelper.get_all(pgnum, pgsize)
      
    else
      @data = SettingHelper.get_filter_by(keyword, pgnum, pgsize)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /setting/new
  # GET /setting/new.json
  def new
    @setting = Setting.new
    @form_id = 'add-form'
    @designation_list = Designation.order('title').all
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @setting }
    end
  end
  
  # POST /setting/create
  def create
    o = Setting.new(:designation_id => params[:designation_id], :dailyallowance => params[:dailyallowance],
                    :epf => params[:epf], :socso => params[:socso], :incometax => params[:incometax])
                    
    if o.save
      render :json => { :success => 1 }
      
    else
      render :json => SettingHelper.get_errors(o.errors, params)
    end
  end
  
  # GET /setting/1
  # GET /setting/1.json
  def edit
    @setting = Setting.find(params[:id])
    @form_id = 'edit-form'
    @designation_list = Designation.order('title').all
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @setting }
    end
  end
  
  # POST /setting/update/1
  def update
    o = Setting.find(params[:id])
    
    if o.update_attributes(:designation_id => params[:designation_id], :dailyallowance => params[:dailyallowance],
                           :epf => params[:epf], :socso => params[:socso], :incometax => params[:incometax])
      render :json => { :success => 1 }
      
    else
      render :json => SettingHelper.get_errors(o.errors, params)
    end
  end
  
  # POST /setting/delete
  def destroy
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    lsid = ids.split(',')
    Setting.delete_all(:id => lsid)
    
    itemscount = SettingHelper.item_message(keyword, pgnum, pgsize)
    
    render :json => { :success => 1, :itemscount => itemscount }
  end
end
