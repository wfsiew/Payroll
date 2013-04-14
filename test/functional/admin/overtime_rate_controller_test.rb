require 'test_helper'

class Admin::OvertimeRateControllerTest < ActionController::TestCase
  setup do
    @rate = overtime_rate(:one)
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
    get :list, { :year => 2008 }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
  
  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:rate)
    assert_not_nil assigns(:form_id)
    assert_equal 'add-form', assigns(:form_id)
  end
  
  test "should create overtime rate" do
    login_as :admin
    assert_difference('OvertimeRate.count') do
      post :create, { :duration => @rate.duration, :year => 2011, :pay_rate => @rate.pay_rate }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should get edit" do
    login_as :admin
    get :edit, { :id => @rate.id }
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:rate)
    assert_not_nil assigns(:form_id)
    assert_equal 'edit-form', assigns(:form_id)
  end
  
  test "should update overtime rate" do
    login_as :admin
    post :update, { :id => @rate.id, :duration => @rate.duration, :year => 2005, 
                    :pay_rate => @rate.pay_rate }
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should destroy overtime rate" do
    login_as :admin
    assert_difference('OvertimeRate.count', -1) do
      post :destroy, { :id => [@rate.id] }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
    assert_equal '1 to 1 of 1', data['itemscount']
  end
end
