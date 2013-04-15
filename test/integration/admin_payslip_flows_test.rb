require 'test_helper'

class AdminPayslipFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:admin)
  end

  test 'browse and view payslip' do 
    a = admin_user(AdminPayslipFlows)
    a.logs_in @user.username, 'secret'
    a.browse
    a.logs_out
  end

  private

  module AdminPayslipFlows
    def browse
      get admin_payslip_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:data)
      assert_not_nil assigns(:employmentstatus)
      assert_not_nil assigns(:designation)
      assert_not_nil assigns(:dept)

      get admin_payslip_list_path, { :employee => 'ben' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)

      get admin_payslip_slip_path, { :id => 1 }
      assert_response :success
      assert_template 'payslip_monthly'
      assert_not_nil assigns(:employee)
      assert_not_nil assigns(:employee_salary)
      assert_not_nil assigns(:period)
      assert_not_nil assigns(:total_overtime)
      assert_not_nil assigns(:total_overtime_earnings)
      assert_not_nil assigns(:adjustment)
      assert_not_nil assigns(:total_earnings)
      assert_not_nil assigns(:total_deduct)
      assert_not_nil assigns(:nett_salary)
      assert_not_nil assigns(:basic_pay)

      get admin_payslip_slip_path, { :id => 2 }
      assert_response :success
      assert_template 'payslip_hourly'
      assert_not_nil assigns(:employee)
      assert_not_nil assigns(:employee_salary)
      assert_not_nil assigns(:total_earnings)
      assert_not_nil assigns(:total_hours)
      assert_not_nil assigns(:hourly_pay_rate)
      assert_not_nil assigns(:total_deduct)
      assert_not_nil assigns(:nett_salary)
    end
  end
end
