require 'test_helper'

class Admin::PayslipControllerTest < ActionController::TestCase
  test 'should get index' do
    login_as :admin
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:data)
    assert_not_nil assigns(:employmentstatus)
    assert_not_nil assigns(:designation)
    assert_not_nil assigns(:dept)
  end
  
  test 'should get list' do
    login_as :admin
    get :list, { :employee => 'ben' }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
  
  test 'should get monthly payslip' do
    login_as :admin
    get :payslip, { :id => 1 }
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
  end
  
  test 'should get hourly payslip' do
    login_as :admin
    get :payslip, { :id => 2 }
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
