require 'test_helper'

class UserQualificationFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
  end

  test 'view and update qualification' do
    a = normal_user(UserQualificationFlows)
    a.logs_in @user.username, 'secret'
    a.update
    a.logs_out
  end

  private

  module UserQualificationFlows
    def update
      get user_qualification_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:employee_qualification)

      post user_qualification_update_path, { 
        :employee_qualification => { 
          :level => @employee_qualification.level, :institute => @employee_qualification.institute, 
          :major => @employee_qualification.major, :year => 2010, :gpa => @employee_qualification.gpa, 
          :start_date => '03-04-2006', :end_date => '02-04-2010'
        },
      }
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
  end
end
