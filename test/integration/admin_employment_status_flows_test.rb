require 'test_helper'

class AdminEmploymentStatusFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
    @employment_status = employment_status(:one)
  end
  
  test 'login, search, create, update, and delete employment status' do
    a = admin_user(AdminEmploymentStatusFlows)
    a.logs_in @admin.username, 'secret'
    a.search
    a.create :name => 'Contract'
    a.update @employment_status, { :id => @employment_status.id, :name => 'Part time' }
    a.destroy @employment_status
    a.logs_out
  end
  
  private
  
  module AdminEmploymentStatusFlows
    def search
      get admin_empstatus_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:data)
      
      get admin_empstatus_list_path, { :keyword => 'bat' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end
    
    def create(obj_hash)
      get admin_empstatus_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:empstatus)
      
      assert_difference('EmploymentStatus.count') do
        post admin_empstatus_create_path, obj_hash
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def update(o, obj_hash)
      get admin_empstatus_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:empstatus)

      post admin_empstatus_update_path, obj_hash
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def destroy(o)
      assert_difference('EmploymentStatus.count', -1) do
        post admin_empstatus_delete_path, { :id => [o.id] }
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 2 of 2', data['itemscount']
    end
  end
end
