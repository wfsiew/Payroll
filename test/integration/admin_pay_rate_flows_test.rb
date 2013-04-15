require 'test_helper'

class AdminPayRateFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
    @rate = pay_rate(:one)
  end
  
  test 'login, search, create, update, and delete pay rate' do
    a = admin_user(AdminPayRateFlows)
    a.logs_in @admin.username, 'secret'
    a.search
    a.create :staff_id => 'C0007',
             :month => @rate.month, :year => @rate.year,
             :pay_rate => @rate.hourly_pay_rate
    a.update @rate, { :id => @rate.id, :staff_id => 'C0006', :month => 6, 
                      :year => 2012, :pay_rate => 3.4 }
    a.destroy @rate
    a.logs_out
  end
  
  private
  
  module AdminPayRateFlows
    def search
      get admin_payrate_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:data)
      
      get admin_payrate_list_path, { :staff_id => 'C0001' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end
    
    def create(obj_hash)
      get admin_payrate_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:payrate)
      assert_not_nil assigns(:form_id)
      assert_equal 'add-form', assigns(:form_id)
      
      assert_difference('PayRate.count') do
        post admin_payrate_create_path, obj_hash
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def update(o, obj_hash)
      get admin_payrate_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:payrate)
      assert_not_nil assigns(:form_id)
      assert_equal 'edit-form', assigns(:form_id)

      post admin_payrate_update_path, obj_hash
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def destroy(o)
      assert_difference('PayRate.count', -1) do
        post admin_payrate_delete_path, { :id => [o.id] }
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 2 of 2', data['itemscount']
    end
  end
end
