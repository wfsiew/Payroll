require 'test_helper'

class Admin::TotalWorkHoursChartControllerTest < ActionController::TestCase
  test 'should get index' do
    login_as :admin
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:month_hash)
  end
  
  test 'should get data' do
    login_as :admin
    get :data
    assert_response :success
    assert_not_nil assigns(:data)
  end
end
