require 'test_helper'

class AdminDepartmentFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
    @dept = department(:one)
  end
  
  test 'login, search, create, update, and delete department' do
    a = admin_user(AdminDepartmentFlows)
    a.logs_in @admin.username, 'secret'
    a.search
    a.create :name => 'Sales'
    a.update @dept, { :id => @dept.id, :name => 'Admin' }
    a.destroy @dept
    a.logs_out
  end
  
  private
  
  module AdminDepartmentFlows
    def search
      get admin_dept_path
      assert_template 'index'
      assert_not_nil assigns(:data)

      get admin_dept_list_path, { :keyword => 'r' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end
    
    def create(obj_hash)
      get admin_dept_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:dept)
      assert_not_nil assigns(:form_id)
      assert_equal 'add-form', assigns(:form_id)

      assert_difference('Department.count') do
        post admin_dept_create_path, obj_hash
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def update(o, obj_hash)
      get admin_dept_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:dept)
      assert_not_nil assigns(:form_id)
      assert_equal 'edit-form', assigns(:form_id)

      post admin_dept_update_path, obj_hash

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def destroy(o)
      assert_difference('Department.count', -1) do
        post admin_dept_delete_path, { :id => [o.id] }
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 2 of 2', data['itemscount']
    end
  end
end
