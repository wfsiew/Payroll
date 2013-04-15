require 'test_helper'

class User::SalaryControllerTest < ActionController::TestCase
  test 'should get index' do
    login_as :ben
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:employee)
    assert_not_nil assigns(:employee_salary)
    assert_not_nil assigns(:adjustment)
    assert_not_nil assigns(:basic_pay)
  end
end
