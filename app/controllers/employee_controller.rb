require 'securerandom'

class EmployeeController < ApplicationController
  layout false
  
  # GET /employee
  # GET /employee.json
  def index
    @data = EmployeeHelper.get_all(1, ApplicationHelper::Pager.default_page_size)
    
    respond_to do |fmt|
      fmt.html { render 'index', :layout => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /employee/list
  # GET /employee/list.json
  def list
    find = params[:find].blank? ? 0 : params[:find].to_i
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    
    if find == 0 && keyword.blank?
      @data = EmployeeHelper.get_all(pgnum, pgsize)
      
    else
      @data = EmployeeHelper.get_filter_by(find, keyword, pgnum, pgsize)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /employee/new
  # GET /employee/new.json
  def new
    @employee = Employee.new
    @form_id = 'add-form'
    @designation_list = Designation.order('title').all
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @employee }
    end
  end
  
  # POST /employee/create
  def create
    o = Employee.new(:id => SecureRandom.uuid, :code => params[:code], :firstname => params[:firstname],
                     :middlename => params[:middlename], :lastname => params[:lastname], :icno => params[:icno],
                     :salary => params[:salary], :designation_id => params[:designation_id], :epfno => params[:epfno],
                     :socso => params[:socso])
    a = Address.new(params[:street], params[:city], params[:state], params[:postalcode], params[:country])
    
    address_valid = a.valid?
    employee_valid = o.valid?
    
    if address_valid && employee_valid
      o.address = a
      if o.save
        render :json => { :success => 1 }
          
      else
        render :json => EmployeeHelper.get_errors(o.errors, a.errors, params)
      end
        
    else
      render :json => EmployeeHelper.get_errors(o.errors, a.errors, params)
    end
  end
  
  # GET /employee/edit/1
  # GET /employee/edit/1.json
  def edit
    @employee = Employee.find(params[:id])
    @form_id = 'edit-form'
    @designation_list = Designation.order('title').all
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @employee }
    end
  end
  
  # POST /employee/update/1
  def update
    o = Employee.find(params[:id])
    
    a = Address.new(params[:street], params[:city], params[:state], params[:postalcode], params[:country])
    
    o.code = params[:code]
    o.firstname = params[:firstname]
    o.middlename = params[:middlename]
    o.lastname = params[:lastname]
    o.icno = params[:icno]
    o.salary = params[:salary]
    o.designation_id = params[:designation_id]
    o.epfno = params[:epfno]
    o.socso = params[:socso]
    
    address_valid = a.valid?
    employee_valid = o.valid?
    
    if address_valid && employee_valid
      o.address = a
      if o.save
        render :json => { :success => 1 }
          
      else
        render :json => EmployeeHelper.get_errors(o.errors, a.errors, params)
      end
        
    else
      render :json => EmployeeHelper.get_errors(o.errors, a.errors, params)
    end
  end
  
  # POST /employee/delete
  def destroy
    find = params[:find].blank? ? 0 : params[:find].to_i
    keyword = params[:keyword].blank? ? '' : params[:keyword]
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    lsid = ids.split(',')
    Designation.delete_all(:id => lsid)
    
    itemscount = EmployeeHelper.item_message(find, keyword, pgnum, pgsize)
    
    render :json => { :success => 1, :itemscount => itemscount }
  end
end
