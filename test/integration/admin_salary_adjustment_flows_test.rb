require 'test_helper'

class AdminSalaryAdjustmentFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
    @adj = salary_adjustment(:one)
  end
  
  test 'login, search, create, update, and delete salary adjustment' do
    a = admin_user(AdminSalaryAdjustmentFlows)
    a.logs_in @admin.username, 'secret'
    a.search
    a.create :staff_id => 'C0003', :inc => 300, :month => 8, :year => 2013
    a.update @adj, { :id => @adj.id, :staff_id => 'C0003', :inc => 250, 
                      :month => 10, :year => 2013 }
    a.destroy @adj
    a.logs_out
  end
  
  private
  
  module AdminSalaryAdjustmentFlows
    def search
      get admin_salaryadj_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:data)

      get admin_salaryadj_list_path, { :staff_id => 'C0001' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end
    
    def create(obj_hash)
      get admin_salaryadj_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:adj)
      assert_not_nil assigns(:form_id)
      assert_equal 'add-form', assigns(:form_id)
      
      assert_difference('SalaryAdjustment.count') do
        post admin_salaryadj_create_path, obj_hash
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def update(o, obj_hash)
      get admin_salaryadj_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:adj)
      assert_not_nil assigns(:form_id)
      assert_equal 'edit-form', assigns(:form_id)

      post admin_salaryadj_update_path, obj_hash
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def destroy(o)
      assert_difference('SalaryAdjustment.count', -1) do
        post admin_salaryadj_delete_path, { :id => [o.id] }
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 2 of 2', data['itemscount']
    end
  end
end
