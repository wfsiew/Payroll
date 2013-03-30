require 'test_helper'

class Admin::DesignationControllerTest < ActionController::TestCase
  setup do
    @des = designation(:one)
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
    get :list, { :keyword => 'rammer' }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
  
  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:designation)
    assert_not_nil assigns(:form_id)
    assert_equal 'add-form', assigns(:form_id)
  end
  
  test "should create designation" do
    login_as :admin
    assert_difference('Designation.count') do
      post :create, { :title => 'Account', :desc => 'Accounting', :note => 'account related tasks' }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should get edit" do
    login_as :admin
    get :edit, { :id => @des.id }
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:designation)
    assert_not_nil assigns(:form_id)
    assert_equal 'edit-form', assigns(:form_id)
  end
  
  test "should update designation" do
    login_as :admin
    post :update, { :id => @des.id, :title => 'Audit', :desc => 'Audit job', :note => 'Audit task' }
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should destroy designation" do
    login_as :admin
    assert_difference('Designation.count', -1) do
      post :destroy, { :id => [@des.id] }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
    assert_equal '1 to 1 of 1', data['itemscount']
  end
end
