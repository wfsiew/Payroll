require 'test_helper'

class Admin::AdminControllerTest < ActionController::TestCase
  test 'should get index' do
    login_as :admin
    get :index
    assert_response :success
  end
end
