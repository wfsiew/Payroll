require 'test_helper'

class Admin::DepartmentControllerTest < ActionController::TestCase
  setup do
    @dept = department(:one)
  end
  
  test 'should get index' do
    login_as :admin
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:data)
  end
  
  test 'should get list' do
    login_as :admin
    get :list, { :keyword => 'r' }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
  
  test 'should get new' do
    login_as :admin
    get :new
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:dept)
    assert_not_nil assigns(:form_id)
    assert_equal 'add-form', assigns(:form_id)
  end
  
  test 'should create department' do
    login_as :admin
    assert_difference('Department.count') do
      post :create, { :name => 'Sales' }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test 'should get edit' do
    login_as :admin
    get :edit, { :id => @dept.id }
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:dept)
    assert_not_nil assigns(:form_id)
    assert_equal 'edit-form', assigns(:form_id)
  end
  
  test 'should update department' do
    login_as :admin
    post :update, { :id => @dept.id, :name => 'Admin' }
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test 'should destroy department' do
    login_as :admin
    assert_difference('Department.count', -1) do
      post :destroy, { :id => [@dept.id] }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
    assert_equal '1 to 1 of 1', data['itemscount']
  end
end
