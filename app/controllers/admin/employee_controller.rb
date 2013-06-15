require 'securerandom'

# This controller serves incoming requests to display out the Employee records.
class Admin::EmployeeController < Admin::AdminController
  
  # List all records.
  # GET /employee
  # GET /employee.json
  def index
    @data = EmployeeHelper.get_all
    @employmentstatus = EmploymentStatus.order(:name).all
    @designation = Designation.order(:title).all
    @dept = Department.order(:name).all
    
    respond_to do |fmt|
      fmt.html { render :layout => LAYOUT[:list] }
      fmt.json { render :json => @data }
    end
  end
  
  # List records by filtering.
  # GET /employee/list
  # GET /employee/list.json
  def list
    employee = params[:employee].blank? ? '' : params[:employee]
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    employment_status = params[:employment_status].blank? ? 0 : 
      params[:employment_status].to_i
    designation = params[:designation].blank? ? 0 : params[:designation].to_i
    dept = params[:dept].blank? ? 0 : params[:dept].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    sortcolumn = params[:sortcolumn].blank? ? EmployeeHelper::DEFAULT_SORT_COLUMN 
                                            : params[:sortcolumn]
    sortdir = params[:sortdir].blank? ? EmployeeHelper::DEFAULT_SORT_DIR : 
      params[:sortdir]
    
    sort = ApplicationHelper::Sort.new(sortcolumn, sortdir)
    
    filters = { :employee => employee,
                :staff_id => staff_id,
                :employment_status => employment_status,
                :designation => designation,
                :dept => dept }
                
    if employee.blank? && staff_id.blank? && employment_status == 0 && designation == 0 && 
      dept == 0
      @data = EmployeeHelper.get_all(pgnum, pgsize, sort)
      
    else
      @data = EmployeeHelper.get_filter_by(filters, pgnum, pgsize, sort)
    end
    
    respond_to do |fmt|
      fmt.html { render :partial => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # Display the Employee form.
  # GET /employee/new
  # GET /employee/new.json
  def new
    @employee = Employee.new
    @employee_contact = EmployeeContact.new
    @employee_job = EmployeeJob.new
    @employee_salary = EmployeeSalary.new
    @employee_qualification = EmployeeQualification.new
    @form_id = 'add-form'
    @users = User.order(:username).all
    @designations = Designation.order(:title).all
    @employment_statuses = EmploymentStatus.order(:name).all
    @job_categories = JobCategory.order(:name).all
    @departments = Department.order(:name).all
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @employee }
    end
  end
  
  # Create new Employee record.
  # POST /employee/create
  def create
    o = EmployeeHelper.employee_obj(nil, params)
         
    b1 = EmployeeContactHelper.is_empty_params?(params)
    oc = EmployeeContactHelper.employee_contact_obj(o, nil, params)

    b2 = EmployeeJobHelper.is_empty_params?(params)                         
    oej = EmployeeJobHelper.employee_job_obj(o, nil, params)
           
    b3 = EmployeeSalaryHelper.is_empty_params?(params)                  
    osa = EmployeeSalaryHelper.employee_salary_obj(o, nil, params)
    
    b4 = EmployeeQualificationHelper.is_empty_params?(params)                          
    oq = EmployeeQualificationHelper.employee_qualification_obj(o, nil, params)
                              
    v1 = o.valid?
    v2 = b1 ? true : oc.valid?
    v3 = b2 ? true : oej.valid?
    v4 = b3 ? true : osa.valid?
    v5 = b4 ? true : oq.valid?
    
    if !v1 || !v2 || !v3 || !v4 || !v5
      employee_errors = EmployeeHelper.get_errors(o.errors)
      employee_contact_errors = EmployeeContactHelper.get_errors(oc.errors)
      employee_job_errors = EmployeeJobHelper.get_errors(oej.errors)
      employee_salary_errors = EmployeeSalaryHelper.get_errors(osa.errors)
      employee_qualification_errors = EmployeeQualificationHelper.get_errors(oq.errors)
      
      errors = { :error => 1, :employee => employee_errors,
                              :employee_contact => employee_contact_errors,
                              :employee_job => employee_job_errors,
                              :employee_salary => employee_salary_errors,
                              :employee_qualification => employee_qualification_errors }
      render :json => errors and return
    end
               
    ActiveRecord::Base.transaction do
      o.save
      oc.save unless b1
      oej.save unless b2
      osa.save unless b3
      oq.save unless b4
    end
    
    render :json => { :success => 1, 
                      :message => 'Employee was successfully added.' }
  end
  
  # Display the Employee form, with existing record to edit.
  # GET /employee/edit/1
  # GET /employee/edit/1.json
  def edit
    @employee = Employee.find(params[:id])
    @employee_contact = @employee.employee_contact.blank? ? EmployeeContact.new 
                                                          : @employee.employee_contact
    @employee_job = @employee.employee_job.blank? ? EmployeeJob.new 
                                                  : @employee.employee_job
    @employee_salary = @employee.employee_salary.blank? ? EmployeeSalary.new 
                                                        : @employee.employee_salary
    @employee_qualification = @employee.employee_qualification.blank? ? 
      EmployeeQualification.new : @employee.employee_qualification
    @form_id = 'edit-form'
    @users = User.order(:username).all
    @designations = Designation.order(:title).all
    @employment_statuses = EmploymentStatus.order(:name).all
    @job_categories = JobCategory.order(:name).all
    @departments = Department.order(:name).all
    
    respond_to do |fmt|
      fmt.html { render :partial => 'form' }
      fmt.json { render :json => @employee }
    end
  end
  
  # Update Employee record.
  # POST /employee/update
  def update
    o = Employee.find(params[:id])
    oc = o.employee_contact
    oej = o.employee_job
    osa = o.employee_salary
    oq = o.employee_qualification

	  o = EmployeeHelper.employee_obj(o, params)
	  oc = EmployeeContactHelper.employee_contact_obj(o, oc, params)
	  oej = EmployeeJobHelper.employee_job_obj(o, oej, params)
	  osa = EmployeeSalaryHelper.employee_salary_obj(o, osa, params)
	  oq = EmployeeQualificationHelper.employee_qualification_obj(o, oq, params)
    
    oc_new = false
    if oc.blank?
      
      oc_new = true
    end
    
    oej_new = false
    if oej.blank?
      
      oej_new = true
    end
    
    osa_new = false
    if osa.blank?
      
      osa_new = true
    end
    
    oq_new = false
    if oq.blank?
      
      oq_new = true
    end
    
    b1 = EmployeeContactHelper.is_empty_params?(params)
    b2 = EmployeeJobHelper.is_empty_params?(params)
    b3 = EmployeeSalaryHelper.is_empty_params?(params)
    b4 = EmployeeQualificationHelper.is_empty_params?(params)
    
    v1 = o.valid?
    v2 = b1 ? true : oc.valid?
    v3 = b2 ? true : oej.valid?
    v4 = b3 ? true : osa.valid?
    v5 = b4 ? true : oq.valid?
    
    if !v1 || !v2 || !v3 || !v4 || !v5
      employee_errors = EmployeeHelper.get_errors(o.errors)
      employee_contact_errors = EmployeeContactHelper.get_errors(oc.errors)
      employee_job_errors = EmployeeJobHelper.get_errors(oej.errors)
      employee_salary_errors = EmployeeSalaryHelper.get_errors(osa.errors)
      employee_qualification_errors = EmployeeQualificationHelper.get_errors(oq.errors)
      
      errors = { :error => 1, :employee => employee_errors,
                              :employee_contact => employee_contact_errors,
                              :employee_job => employee_job_errors,
                              :employee_salary => employee_salary_errors,
                              :employee_qualification => employee_qualification_errors }
      render :json => errors and return
    end
    
    ActiveRecord::Base.transaction do
      o.save
      oc.save unless b1
      oej.save unless b2
      osa.save unless b3
      oq.save unless b4
    end
    
    render :json => { :success => 1, 
                      :message => 'Employee was successfully updated.' }
  end
  
  # Delete a list of Employee records.
  # POST /employee/delete
  def destroy
    employee = params[:employee].blank? ? '' : params[:employee]
    staff_id = params[:staff_id].blank? ? '' : params[:staff_id]
    employment_status = params[:employment_status].blank? ? 0 : params[:employment_status].to_i
    designation = params[:designation].blank? ? 0 : params[:designation].to_i
    dept = params[:dept].blank? ? 0 : params[:dept].to_i
    pgnum = params[:pgnum].blank? ? 1 : params[:pgnum].to_i
    pgsize = params[:pgsize].blank? ? 0 : params[:pgsize].to_i
    ids = params[:id]
    
    ActiveRecord::Base.transaction do
      Employee.delete_all(:id => ids)
      EmployeeContact.delete_all(:id => ids)
      EmployeeJob.delete_all(:id => ids)
      EmployeeSalary.delete_all(:id => ids)
      EmployeeQualification.delete_all(:id => ids)
    end
    
    filters = { :employee => employee,
                :staff_id => staff_id,
                :employment_status => employment_status,
                :designation => designation,
                :dept => dept }
    
    if employee.blank? && staff_id.blank? && employment_status == 0 && designation == 0 && 
      dept == 0
      itemscount = EmployeeHelper.item_message(nil, pgnum, pgsize)
      
    else
      itemscount = EmployeeHelper.item_message(filters, pgnum, pgsize)
    end
    
    render :json => { :success => 1, 
                      :itemscount => itemscount, 
                      :message => "#{ids.size} employee(s) was successfully deleted." }
  end
end
