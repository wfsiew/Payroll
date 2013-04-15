require 'test_helper'

class AdminEmployeeFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:admin)
    @employee = employee(:one)
    @employee_contact = employee_contact(:one)
    @employee_job = employee_job(:one)
    @employee_salary = employee_salary(:one)
    @employee_qualification = employee_qualification(:one)
  end

  test '' do
    a = admin_user(AdminEmployeeFlows)
    a.logs_in @user.username, 'secret'

    a.create
      :employee => { 
        :staff_id => 'C0003', :first_name => 'wong', :middle_name => 'yan', 
        :last_name => 'kin', :new_ic => '098455673', :old_ic => '88744532', 
        :passport_no => @employee.passport_no, :gender => @employee.gender, 
        :marital_status => @employee.marital_status, :nationality => @employee.nationality, 
        :dob => '15-08-1977', :place_of_birth => @employee.place_of_birth, 
        :race => @employee.race, :religion => @employee.religion, 
        :is_bumi => @employee.is_bumi, :user_id => @employee.user_id 
      },
      
      :employee_contact => { 
        :id => @employee_contact.id, :address_1 => @employee_contact.address_1, 
        :address_2 => @employee_contact.address_2, 
        :address_3 => @employee_contact.address_3, :city => @employee_contact.city, 
        :state => @employee_contact.state, :postcode => @employee_contact.postcode, 
        :country => @employee_contact.country, :home_phone => @employee_contact.home_phone, 
        :mobile_phone => @employee_contact.mobile_phone, 
        :work_email => @employee_contact.work_email, 
        :other_email => @employee_contact.other_email 
      },
      
      :employee_job => { 
        :id => @employee_job.id, :designation_id => @employee_job.designation_id, 
        :department_id => @employee_job.department_id, 
        :employment_status_id => @employee_job.employment_status_id, 
        :job_category_id => @employee_job.job_category_id, :join_date => '09-03-2011', 
        :confirm_date => '09-06-2011' 
      },
      
      :employee_salary => {
        :id => @employee_salary.id, :salary => @employee_salary.salary, 
        :allowance => @employee_salary.allowance, :epf => @employee_salary.epf, 
        :socso => @employee_salary.socso, :income_tax => @employee_salary.income_tax, 
        :bank_name => @employee_salary.bank_name, 
        :bank_acc_no => @employee_salary.bank_acc_no, 
        :bank_acc_type => @employee_salary.bank_acc_type, 
        :bank_address => @employee_salary.bank_address, 
        :epf_no => @employee_salary.epf_no, :socso_no => @employee_salary.socso_no, 
        :income_tax_no => @employee_salary.income_tax_no, 
        :pay_type => @employee_salary.pay_type
      },
      
      :employee_qualification => {
        :id => @employee_qualification.id, :level => @employee_qualification.level, 
        :institute => @employee_qualification.institute, 
        :major => @employee_qualification.major, :year => 2010, 
        :gpa => @employee_qualification.gpa, :start_date => '03-04-2006', 
        :end_date => '02-04-2010'
      }

    a.update @employee,
    {
      :id => @employee.id,
      :employee => { 
          :staff_id => 'C0005', :first_name => @employee.first_name, :middle_name => @employee.middle_name, 
          :last_name => @employee.last_name, :new_ic => @employee.new_ic, :old_ic => @employee.old_ic, 
          :passport_no => @employee.passport_no, :gender => @employee.gender, :marital_status => @employee.marital_status, 
          :nationality => @employee.nationality, :dob => '15-08-1977', :place_of_birth => @employee.place_of_birth, 
          :race => @employee.race, :religion => @employee.religion, :is_bumi => @employee.is_bumi, :user_id => @employee.user_id 
        },
        
        :employee_contact => { 
          :id => @employee_contact.id, :address_1 => @employee_contact.address_1, :address_2 => @employee_contact.address_2, 
          :address_3 => @employee_contact.address_3, :city => @employee_contact.city, :state => @employee_contact.state, 
          :postcode => @employee_contact.postcode, :country => @employee_contact.country, :home_phone => @employee_contact.home_phone, 
          :mobile_phone => @employee_contact.mobile_phone, :work_email => @employee_contact.work_email, 
          :other_email => @employee_contact.other_email 
        },
        
        :employee_job => { 
          :id => @employee_job.id, :designation_id => @employee_job.designation_id, :department_id => @employee_job.department_id, 
          :employment_status_id => @employee_job.employment_status_id, :job_category_id => @employee_job.job_category_id, 
          :join_date => '09-03-2011', :confirm_date => '09-06-2011' 
        },
        
        :employee_salary => {
          :id => @employee_salary.id, :salary => @employee_salary.salary, :allowance => @employee_salary.allowance, 
          :epf => @employee_salary.epf, :socso => @employee_salary.socso, :income_tax => @employee_salary.income_tax, 
          :bank_name => @employee_salary.bank_name, :bank_acc_no => @employee_salary.bank_acc_no, 
          :bank_acc_type => @employee_salary.bank_acc_type, :bank_address => @employee_salary.bank_address, 
          :epf_no => @employee_salary.epf_no, :socso_no => @employee_salary.socso_no, :income_tax_no => @employee_salary.income_tax_no,
          :pay_type => @employee_salary.pay_type
        },
        
        :employee_qualification => {
          :id => @employee_qualification.id, :level => @employee_qualification.level, :institute => @employee_qualification.institute, 
          :major => @employee_qualification.major, :year => 2010, :gpa => @employee_qualification.gpa, 
          :start_date => '03-04-2006', :end_date => '02-04-2010'
        }
    }

    a.destroy @employee
    a.logs_out
  end

  private

  module AdminEmployeeFlows
    def search
      get admin_employee_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:data)
      assert_not_nil assigns(:employmentstatus)
      assert_not_nil assigns(:designation)
      assert_not_nil assigns(:dept)

      get admin_employee_list_path, { :staff_id => 'C0001' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end

    def create(obj_hash)
      get admin_employee_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:employee)
      assert_not_nil assigns(:employee_contact)
      assert_not_nil assigns(:employee_job)
      assert_not_nil assigns(:employee_salary)
      assert_not_nil assigns(:employee_qualification)
      assert_not_nil assigns(:form_id)
      assert_not_nil assigns(:users)
      assert_not_nil assigns(:designations)
      assert_not_nil assigns(:employment_statuses)
      assert_not_nil assigns(:job_categories)
      assert_not_nil assigns(:departments)
      assert_equal 'add-form', assigns(:form_id)

      assert_difference('Employee.count') do
        post admin_employee_create_path, obj_hash
      end
      
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end

    def update(o, obj_hash)
      get admin_employee_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:employee)
      assert_not_nil assigns(:employee_contact)
      assert_not_nil assigns(:employee_job)
      assert_not_nil assigns(:employee_salary)
      assert_not_nil assigns(:employee_qualification)
      assert_not_nil assigns(:form_id)
      assert_not_nil assigns(:users)
      assert_not_nil assigns(:designations)
      assert_not_nil assigns(:employment_statuses)
      assert_not_nil assigns(:job_categories)
      assert_not_nil assigns(:designations)
      assert_equal 'edit-form', assigns(:form_id)

      post admin_employee_update_path, obj_hash
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end

    def destroy(o)
      assert_difference('Employee.count', -1) do
        post admin_employee_delete_path, { :id => [o.id] }
      end
      
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 2 of 2', data['itemscount']
    end
  end
end
