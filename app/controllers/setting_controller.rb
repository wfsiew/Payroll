class SettingController < ApplicationController
  layout false
  
  def index
    @data = SettingHelper.get_all(1, ApplicationHelper::Pager.default_page_size)
	
	respond_to do |fmt|
	  fmt.html { render 'index', :layout => 'list' }
	end
  end
  
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
    end
  end
  
  def new
    @setting = Setting.new
    @form_id = 'add-form'
    @designation_list = Designation.order('title').all
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
    end
  end
  
  def create
    o = Setting.new(:designation_id => params[:designation_id], :dailyallowance => params[:dailyallowance],
                    :epf => params[:epf], :socso => params[:socso], :incometax => params[:incometax])
                    
    respond_to do |fmt|
      if o.save
        fmt.json { render :json => { :success => 1 } }
        
      else
        fmt.json { render :json => SettingHelper.get_errors(o.errors, params) }
      end
    end
  end
  
  def edit
    @setting = Setting.find(params[:id])
    @form_id = 'edit-form'
    @designation_list = Designation.order('title').all
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
    end
  end
  
  def update
    o = Setting.find(params[:id])
    
    respond_to do |fmt|
      if o.update_attributes(:designation_id => params[:designation_id], :dailyallowance => params[:dailyallowance],
                             :epf => params[:epf], :socso => params[:socso], :incometax => params[:incometax])
        fmt.json { render :json => { :success => 1 } }
      
      else
        fmt.json { render :json => SettingHelper.get_errors(o.errors, params) }
      end
    end
  end
  
  def destroy
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    lsid = ids.split(',')
    Setting.delete_all(:id => lsid)
    
    itemscount = SettingHelper.item_message(keyword, pgnum, pgsize)
    
    respond_to do |fmt|
      fmt.json { render :json => { :success => 1, :itemscount => itemscount } }
    end
  end
end
