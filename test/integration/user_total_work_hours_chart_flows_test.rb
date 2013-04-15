require 'test_helper'

class UserTotalWorkHoursChartFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
  end

  test 'browse chart' do
    a = normal_user(UserTotalWorkHoursChartFlows)
    a.logs_in @user.username, 'secret'
    a.browse
    a.logs_out
  end

  private

  module UserTotalWorkHoursChartFlows
    def browse
      get user_workhours_chart_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:month_hash)

      get user_workhours_chart_data_path
      assert_response :success
      assert_not_nil assigns(:data)
    end
  end
end
