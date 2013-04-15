require 'test_helper'

class AdminOvertimeChartFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:admin)
  end

  test 'browse chart' do 
    a = admin_user(AdminOvertimeChartFlows)
    a.logs_in @user.username, 'secret'
    a.browse
    a.logs_out
  end

  private

  module AdminOvertimeChartFlows
    def browse
      get admin_overtime_chart_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:month_hash)

      get admin_overtime_chart_data_path
      assert_response :success
      assert_not_nil assigns(:data)
    end
  end
end
