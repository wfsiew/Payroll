require 'test_helper'

class AdminOvertimeRateFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
    @rate = overtime_rate(:one)
  end
  
  test 'login, search, create, update, and delete overtime rate' do
    a = admin_user(AdminOvertimeRateFlows)
    a.logs_in @admin.username, 'secret'
    a.search
    a.create :duration => @rate.duration, :year => 2011, :pay_rate => @rate.pay_rate
    a.update @rate, { :id => @rate.id, :duration => @rate.duration, :year => 2005, 
                      :pay_rate => @rate.pay_rate }
    a.destroy @rate
    a.logs_out
  end
  
  private
  
  module AdminOvertimeRateFlows
    def search
      get admin_overtime_rate_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:data)
      
      get admin_overtime_rate_list_path, { :year => 2008 }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end
    
    def create(obj_hash)
      get admin_overtime_rate_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:rate)
      assert_not_nil assigns(:form_id)
      assert_equal 'add-form', assigns(:form_id)
      
      assert_difference('OvertimeRate.count') do
        post admin_overtime_rate_create_path, obj_hash
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def update(o, obj_hash)
      get admin_overtime_rate_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:rate)
      assert_not_nil assigns(:form_id)
      assert_equal 'edit-form', assigns(:form_id)
      
      post admin_overtime_rate_update_path, obj_hash
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def destroy(o)
      assert_difference('OvertimeRate.count', -1) do
        post admin_overtime_rate_delete_path, { :id => [o.id] }
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 2 of 2', data['itemscount']
    end
  end
end
