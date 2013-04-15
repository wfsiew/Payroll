require 'test_helper'

class User::OvertimeChartControllerTest < ActionController::TestCase
  test 'should get index' do
    login_as :ben
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:month_hash)
  end
  
  test 'should get data' do
    login_as :ben
    get :data
    assert_response :success
    assert_not_nil assigns(:data)
  end
end
