require 'test_helper'

class AdminDesignationFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
    @des = designation(:one)
  end
  
  test 'login, search, create, update, and delete designation' do
    a = admin_user(AdminDesignationFlows)
    a.logs_in @admin.username, 'secret'
    a.search
    a.create :title => 'Account', :desc => 'Accounting', 
             :note => 'account related tasks'
    a.update @des, { :id => @des.id, :title => 'Audit', :desc => 'Audit job', 
                     :note => 'Audit task' }
    a.destroy @des
    a.logs_out
  end
  
  private
  
  module AdminDesignationFlows
    def search
      get admin_designation_path
      assert_template 'index'
      assert_not_nil assigns(:data)
        
      get admin_designation_list_path, { :keyword => 'rammer' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end
      
    def create(obj_hash)
      get admin_designation_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:designation)
      assert_not_nil assigns(:form_id)
      assert_equal 'add-form', assigns(:form_id)
        
      assert_difference('Designation.count') do
        post admin_designation_create_path, obj_hash
      end
           
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
      
    def update(o, obj_hash)
      get admin_designation_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:designation)
      assert_not_nil assigns(:form_id)
      assert_equal 'edit-form', assigns(:form_id)

      post admin_designation_update_path, obj_hash

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
      
    def destroy(o)
      assert_difference('Designation.count', -1) do
        post admin_designation_delete_path, { :id => [o.id] }
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 2 of 2', data['itemscount']
    end
  end
end
