require 'test_helper'

class AdminAttendanceFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
  end
  
  test 'browse attendance' do
    a = admin_user(AdminAttendanceFlows)
    a.logs_in @admin.username, 'secret'
    a.browse
    a.logs_out
  end
  
  private
  
  module AdminAttendanceFlows
    def browse
      get admin_att_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:data)
      
      get admin_att_list_path, { :work_date => '12-01-2013', :employee => 'ben' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end
  end
end
