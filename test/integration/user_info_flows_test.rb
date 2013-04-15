require 'test_helper'

class UserInfoFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
    @employee = employee(:one)
  end

  test 'view and update info' do 
    a = normal_user(UserInfoFlows)
    a.logs_in @user.username, 'secret'
    a.update
    a.logs_out
  end

  private

  module UserInfoFlows
    def update
      get user_info_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:employee)
      assert_not_nil assigns(:user)

      post user_info_update_path, {
        :employee => { 
          :first_name => 'wong', :middle_name => 'yan', :last_name => 'kin', :new_ic => '098455673', :old_ic => '88744532', 
          :passport_no => @employee.passport_no, :gender => @employee.gender, :marital_status => @employee.marital_status, 
          :nationality => @employee.nationality, :dob => '15-08-1977', :place_of_birth => @employee.place_of_birth, 
          :race => @employee.race, :religion => @employee.religion, :is_bumi => @employee.is_bumi
        }
      }
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
  end
end
