require 'test_helper'

class Admin::EmploymentStatusControllerTest < ActionController::TestCase
  setup do
    @employment_status = employment_status(:one)
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
    get :list, { :keyword => 'bat' }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
  
  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:empstatus)
  end
  
  test "should create employment status" do
    login_as :admin
    assert_difference('EmploymentStatus.count') do
      post :create, { :name => 'Contract' }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should get edit" do
    login_as :admin
    get :edit, { :id => @employment_status.id }
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:empstatus)
  end
  
  test "should update employment status" do
    login_as :admin
    post :update, { :id => @employment_status.id, :name => 'Part time' }
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should destroy employment status" do
    login_as :admin
    assert_difference('EmploymentStatus.count', -1) do
      post :destroy, { :id => [@employment_status.id] }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
    assert_equal '1 to 1 of 1', data['itemscount']
  end
end
