require 'test_helper'

class UserJobFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
  end

  test 'view job' do
    a = normal_user(UserJobFlows)
    a.logs_in @user.username, 'secret'
    a.view
    a.logs_out
  end

  private

  module UserJobFlows
    def view
      get user_job_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:employee_job)
    end
  end
end
