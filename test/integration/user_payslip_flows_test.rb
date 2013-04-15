require 'test_helper'

class UserPayslipFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @ben = user(:ben)
    @ken = user(:ken)
  end

  test 'view payslip' do
    a = normal_user(UserPayslipFlows)
    b = normal_user(UserPayslipFlows)
    a.logs_in @ben.username, 'secret'
    b.logs_in @ken.username, 'secret'
    a.view_monthly
    b.view_hourly
    a.logs_out
    b.logs_out
  end

  module UserPayslipFlows
    def view_monthly
      get user_payslip_path
      assert_response :success
      assert_template 'index'

      get user_payslip_slip_path, { :id => 2 }
      assert_response :success
      assert_template 'admin/payslip/payslip_monthly'
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
    end

    def view_hourly
      get user_payslip_path
      assert_response :success
      assert_template 'index'

      get :payslip, { :id => 3 }
      assert_response :success
      assert_template 'admin/payslip/payslip_hourly'
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