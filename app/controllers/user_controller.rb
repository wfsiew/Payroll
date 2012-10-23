class UserController < ApplicationController
  layout false
  
  def index
    @data = UserHelper.get_all(1, ApplicationHelper::Pager.default_page_size)
    
    respond_to do |fmt|
      fmt.html { render 'index', :layout => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
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
  
  def new
    @user = User.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @user }
    end
  end
  
  def create
    o = User.new(:username => params[:username], :pwd => params[:pwd], :pwd_confirmation => params[:pwdconfirm])
    
    if o.save
      render :json => { :success => 1 }
      
    else
      render :json => UserHelper.get_errors(o.errors, params)
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
