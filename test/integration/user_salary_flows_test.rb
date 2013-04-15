require 'test_helper'

class UserSalaryFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
  end

  test 'view salary' do
    a = normal_user(UserSalaryFlows)
    a.logs_in @user.username, 'secret'
    a.view
    a.logs_out
  end

  private

  module UserSalaryFlows
    def view
      get user_salary_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:employee)
      assert_not_nil assigns(:employee_salary)
      assert_not_nil assigns(:adjustment)
      assert_not_nil assigns(:basic_pay)
    end
  end
end
