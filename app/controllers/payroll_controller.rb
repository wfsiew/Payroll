require 'time'

class PayrollController < ApplicationController
  layout false
  
  # GET /payroll
  # GET /payroll.json
  def index
    @data = EmployeeHelper.get_all(1, ApplicationHelper::Pager.default_page_size)
    months = I18n.t('date.month_names')
    @month_hash = {}
    
    (1..12).each do |m|
      @month_hash[months[m]] = m
    end
    
    respond_to do |fmt|
      fmt.html { render 'index', :layout => 'list' }
      fmt.json { render :json => @data }
    end
  end
  
  # GET /payroll/list
  # GET /payroll/list.json
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
  
  # GET /payroll/report/1/2
  # GET /payroll/report/1/2.json
  def report
    @employee = Employee.find(params[:id])
    designation = @employee.designation
    @setting = Setting.new
    
    if designation.present?
      @setting = designation.setting
    end
    
    year = Time.now.year
    @period = "#{ApplicationHelper::Utils.month_name(params[:month].to_i)}-#{year}"
    
    @total_earnings = SettingHelper.total_earnings(@employee, @setting)
    @total_deduct = SettingHelper.total_deductions(@setting)
    @nett_salary = SettingHelper.nett_salary(@employee, @setting)
    
    respond_to do |fmt|
      fmt.html { render 'payslip' }
    end
  end
end
