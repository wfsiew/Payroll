require 'test_helper'

class AdminHourlyPayrollChartFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:admin)
  end

  test 'browse chart' do 
    a = admin_user(AdminHourlyPayrollChartFlows)
    a.logs_in @user.username, 'secret'
    a.browse
    a.logs_out
  end

  private

  module AdminHourlyPayrollChartFlows
    def browse
      get admin_hourly_chart_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:month_hash)

      get admin_hourly_chart_data_path
      assert_response :success
      assert_not_nil assigns(:data)
    end
  end
end
