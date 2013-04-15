require 'test_helper'

class UserOvertimeChartFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
  end

  test 'browse chart' do
    a = normal_user(UserOvertimeChartFlows)
    a.logs_in @user.username, 'secret'
    a.browse
    a.logs_out
  end

  module UserOvertimeChartFlows
    def browse
      get user_overtime_chart_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:month_hash)

      get user_overtime_chart_data_path
      assert_response :success
      assert_not_nil assigns(:data)
    end
  end
end
