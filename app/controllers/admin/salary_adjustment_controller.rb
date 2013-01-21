require 'securerandom'

class Admin::SalaryAdjustmentController < Admin::AdminController
  
  # GET /salaryadj
  # GET /salaryadj.json
  def index
    @data = SalaryAdjustmentHelper.get_all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /salaryadj/list
  # GET /salaryadj/list.json
  def list
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    month = params[:month].blank? ? 0 : params[:month].to_i
    year = params[:year].blank? ? 0 : params[:year].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? SalaryAdjustmentHelper::DEFAULT_SORT_COLUMN : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? SalaryAdjustmentHelper::DEFAULT_SORT_DIR : params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    filters = { :staff_id => staff_id,
                :month => month,
                :year => year }
                
    if staff_id.blank? && month == 0 && year == 0
      @data = SalaryAdjustmentHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = SalaryAdjustmentHelper.get_filter_by(filters, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /salaryadj/new
  # GET /salaryadj/new.json
  def new
    @adj = SalaryAdjustment.new
    @form_id = 'add-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @adj }
    end
  end
  
  # POST /salaryadj/create
  def create
    staff_id = params[:staff_id]
    employee = Employee.where(:staff_id => staff_id).first
    employee_salary = employee.employee_salary
    salary = employee_salary.blank? ? 0 : employee_salary.salary
    inc = params[:inc].blank? ? 0 : params[:inc].to_f
    year = params[:year].blank? ? 0 : params[:year].to_i
    
    acc_inc = SalaryAdjustment.where('year < ?', year).sum('inc').to_f
    
    if salary > 0
      amount = salary + inc + acc_inc
      
    else
      amount = 0
    end
    
    o = SalaryAdjustment.new(:id => SecureRandom.uuid, :staff_id => params[:staff_id],
                             :inc => inc, :amount => amount,
                             :month => params[:month], :year => year)
                            
    if o.save
      render :json => { :success => 1, 
                        :message => 'Salary Adjustment successfully added.' }
      
    else
      render :json => SalaryAdjustmentHelper.get_errors(o.errors)
    end
  end
  
  # GET /salaryadj/edit/1
  # GET /salaryadj/edit/1.json
  def edit
    @adj = SalaryAdjustment.find(params[:id])
    @form_id = 'edit-form'
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @adj }
    end
  end
  
  # POST /salaryadj/update
  def update
    o = SalaryAdjustment.find(params[:id])
    inc = params[:inc].blank? ? 0 : params[:inc].to_f
    amount = o.amount - o.inc + inc
    
    if o.update_attributes(:staff_id => params[:staff_id], :inc => inc, 
                           :amount => amount, :month => params[:month], :year => params[:year])
      render :json => { :success => 1, 
                        :message => 'Pay Rate was successfully updated.' }
      
    else
      render :json => PayRateHelper.get_errors(o.errors)
    end
  end
  
  # POST /salaryadj/delete
  def destroy
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    month = params[:month].blank? ? 0 : params[:month].to_i
    year = params[:year].blank? ? 0 : params[:year].to_i
    status = params[:status].blank? ? 0 : params[:status].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    SalaryAdjustment.delete_all(:id => ids)
    
    filters = { :staff_id => staff_id,
                :month => month,
                :year => year }
    
    if staff_id.blank? && month == 0 && year == 0
      itemscount = SalaryAdjustmentHelper.item_message(nil, pgnum, pgsize)
      
    else
      itemscount = SalaryAdjustmentHelper.item_message(filters, pgnum, pgsize)
    end
    
    render :json => { :success => 1, 
                      :itemscount => itemscount, 
                      :message => "#{ids.size} salary adjustment(s) was successfully deleted." }
  end
end
