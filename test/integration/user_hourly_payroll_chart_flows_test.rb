require 'test_helper'

class UserHourlyPayrollChartFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ken)
  end

  test 'browse chart' do
    a = normal_user(UserHourlyPayrollChartFlows)
    a.logs_in @user.username, 'secret'
    a.browse
    a.logs_out
  end

  private

  module UserHourlyPayrollChartFlows
    def browse
      get user_hourly_chart_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:month_hash)

      get user_hourly_chart_data_path
      assert_response :success
      assert_not_nil assigns(:data)
    end
  end
end
