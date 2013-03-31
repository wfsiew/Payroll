require 'test_helper'

class Admin::UserControllerTest < ActionController::TestCase
  setup do
    @user = user(:ben)
  end
  
  test "should get index" do
    login_as :admin
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:data)
  end
  
  test "should get list" do
    login_as :admin
    get :list, { :username => 'en' }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
  
  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:form_id)
    assert_equal 'add-form', assigns(:form_id)
  end
  
  test "should create user" do
    login_as :admin
    assert_difference('User.count') do
      post :create, { :role => 2, :username => 'mary', :status => '1', 
           :pwd => 'abc111', :pwdconfirm => 'abc111' }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should get edit" do
    login_as :admin
    get :edit, { :id => @user.id }
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:form_id)
    assert_equal 'edit-form', assigns(:form_id)
  end
  
  test "should update user" do
    login_as :admin
    post :update, { :id => @user.id, :role => 2, :username => 'mary',
                    :status => '1', :pwd => 'kim111', :pwdconfirm => 'kim111' }
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should destroy user" do
    login_as :admin
    assert_difference('User.count', -1) do
      post :destroy, { :id => [@user.id] }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
    assert_equal '1 to 2 of 2', data['itemscount']
  end
end
