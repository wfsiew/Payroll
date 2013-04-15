require 'test_helper'

class Admin::SalaryAdjustmentControllerTest < ActionController::TestCase
  setup do
    @adj = salary_adjustment(:one)
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
    get :list, { :staff_id => 'C0001' }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
  
  test 'should get new' do
    login_as :admin
    get :new
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:adj)
    assert_not_nil assigns(:form_id)
    assert_equal 'add-form', assigns(:form_id)
  end
  
  test 'should create salary adjustment' do
    login_as :admin
    assert_difference('SalaryAdjustment.count') do
      post :create, { :staff_id => 'C0003', :inc => 300, :month => 8, :year => 2013 }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test 'should get edit' do
    login_as :admin
    get :edit, { :id => @adj.id }
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:adj)
    assert_not_nil assigns(:form_id)
    assert_equal 'edit-form', assigns(:form_id)
  end
  
  test 'should update salary adjustment' do
    login_as :admin
    post :update, { :id => @adj.id, :staff_id => 'C0003', :inc => 250, 
                    :month => 10, :year => 2013 }
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test 'should destroy salary adjustment' do
    login_as :admin
    assert_difference('SalaryAdjustment.count', -1) do
      post :destroy, { :id => [@adj.id] }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
    assert_equal '1 to 1 of 1', data['itemscount']
  end
end
