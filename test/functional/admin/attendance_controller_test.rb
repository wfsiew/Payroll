require 'test_helper'

class Admin::AttendanceControllerTest < ActionController::TestCase
  test 'should get index' do
    login_as :admin
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:data)
  end
  
  test 'should get list' do
    login_as :admin
    get :list, { :work_date => '12-01-2013', :employee => 'ben' }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
end
