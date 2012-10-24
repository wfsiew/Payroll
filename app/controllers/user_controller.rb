class UserController < ApplicationController
  layout false
  
  # GET /user
  # GET /user.json
  def index
    @data = UserHelper.get_all(1, ApplicationHelper::Pager.default_page_size)
    
    respond_to do |fmt|
      fmt.html { render 'index', :layout => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /user/list
  # GET /user/list.json
  def list
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    
    if keyword.blank?
      @data = UserHelper.get_all(pgnum, pgsize)
      
    else
      @data = UserHelper.get_filter_by(keyword, pgnum, pgsize)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /user/new
  # GET /user/new.json
  def new
    @user = User.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @user }
    end
  end
  
  # POST /user/create
  def create
    o = User.new(:username => params[:username], :pwd => params[:pwd], :pwd_confirmation => params[:pwdconfirm])
    
    if o.save
      render :json => { :success => 1 }
      
    else
      render :json => UserHelper.get_errors(o.errors, params)
    end
  end
  
  # GET /user/edit/1
  # GET /user/edit/1.json
  def edit
    @user = User.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @user }
    end
  end
  
  # POST /user/update
  def update
    o = User.find(params[:id])

    if o.update_attributes(:username => params[:username], :pwd => params[:pwd], :pwd_confirmation => params[:pwdconfirm])
      render :json => { :success => 1 }
        
    else
      render :json => UserHelper.get_errors(o.errors, params)
    end
  end
  
  # POST /user/delete
  def destroy
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    lsid = ids.split(',')
    User.delete_all(:id => lsid)
    
    itemscount = UserHelper.item_message(keyword, pgnum, pgsize)
    
    render :json => { :success => 1, :itemscount => itemscount }
  end
end
