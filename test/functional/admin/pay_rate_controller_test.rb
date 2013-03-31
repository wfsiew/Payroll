require 'test_helper'

class Admin::PayRateControllerTest < ActionController::TestCase
  setup do
    @rate = pay_rate(:one)
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
    get :list, { :staff_id => 'C0001' }
    assert_response :success
    assert_template 'list'
    assert_not_nil assigns(:data)
  end
  
  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
    assert_template 'form'
    assert_not_nil assigns(:payrate)
    assert_not_nil assigns(:form_id)
    assert_equal 'add-form', assigns(:form_id)
  end
  
  test "should create pay rate" do
    login_as :admin
    assert_difference('PayRate.count') do
      post :create, { :staff_id => 'C0007', 
                      :month => @rate.month, :year => @rate.year, 
                      :pay_rate => @rate.hourly_pay_rate }
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
    assert_not_nil assigns(:payrate)
    assert_not_nil assigns(:form_id)
    assert_equal 'edit-form', assigns(:form_id)
  end
  
  test "should update pay rate" do
    login_as :admin
    post :update, { :id => @rate.id, :staff_id => 'C0006', :month => 6, 
                    :year => 2012, :pay_rate => 3.4 }
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
  
  test "should destroy pay rate" do
    login_as :admin
    assert_difference('PayRate.count', -1) do
      post :destroy, { :id => [@rate.id] }
    end
    
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
    assert_equal '1 to 1 of 1', data['itemscount']
  end
end
