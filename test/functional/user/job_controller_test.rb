require 'test_helper'

class User::JobControllerTest < ActionController::TestCase
  test 'should get index' do
    login_as :ben
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:employee_job)
  end
end
