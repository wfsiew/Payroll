require 'test_helper'

class UserQualificationFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
    @employee_qualification = employee_qualification(:one)
  end

  test 'view and update qualification' do
    a = normal_user(UserQualificationFlows)
    a.logs_in @user.username, 'secret'
    a.update @employee_qualification
    a.logs_out
  end

  private

  module UserQualificationFlows
    def update(o)
      get user_qualification_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:employee_qualification)

      post user_qualification_update_path, { 
        :employee_qualification => { 
          :level => o.level, :institute => o.institute, 
          :major => o.major, :year => 2010, :gpa => o.gpa, 
          :start_date => '03-04-2006', :end_date => '02-04-2010'
        },
      }
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
  end
end
