require 'test_helper'

class AdminJobCategoryFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
    @jobcat = job_category(:one)
  end
  
  test 'login, search, create, update, and delete job category' do
    a = admin_user(AdminJobCategoryFlows)
    a.logs_in @admin.username, 'secret'
    a.search
    a.create :name => 'Management'
    a.update @jobcat, { :id => @jobcat.id, :name => 'Accounting' }
    a.destroy @jobcat
    a.logs_out
  end
  
  private
  
  module AdminJobCategoryFlows
    def search
      get admin_jobcat_path
      assert_template 'index'
      assert_not_nil assigns(:data)
      
      get admin_jobcat_list_path, { :keyword => 'les' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end
    
    def create(obj_hash)
      get admin_jobcat_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:jobcat)
      assert_not_nil assigns(:form_id)
      assert_equal 'add-form', assigns(:form_id)
        
      assert_difference('JobCategory.count') do
        post admin_jobcat_create_path, obj_hash
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def update(o, obj_hash)
      get admin_jobcat_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:jobcat)
      assert_not_nil assigns(:form_id)
      assert_equal 'edit-form', assigns(:form_id)

      post admin_jobcat_update_path, obj_hash

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
    
    def destroy(o)
      assert_difference('JobCategory.count', -1) do
        post admin_jobcat_delete_path, { :id => [o.id] }
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 2 of 2', data['itemscount']
    end
  end
end
