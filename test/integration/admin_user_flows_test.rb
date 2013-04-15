require 'test_helper'

class AdminUserFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @admin = user(:admin)
    @user = user(:ken)
  end

  test 'login, search, create, update, and delete user' do
    a = admin_user(AdminUserFlows)
    a.logs_in @admin.username, 'secret'
    a.search
    a.create :role => 2, :username => 'jane', :status => '1',
             :pwd => 'abc111', :pwdconfirm => 'abc111'
    a.update @user, { :id => @user.id, :role => 2, :username => 'pauline', :status => '1',
                      :pwd => 'kim111', :pwdconfirm => 'kim111' }
    a.destroy @user
    a.logs_out
  end

  private

  module AdminUserFlows
    def search
      get admin_user_path
      assert_template 'index'
      assert_not_nil assigns(:data)

      get admin_user_list_path, { :username => 'en' }
      assert_response :success
      assert_template 'list'
      assert_not_nil assigns(:data)
    end

    def create(obj_hash)
      get admin_user_new_path
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:user)
      assert_not_nil assigns(:form_id)
      assert_equal 'add-form', assigns(:form_id)

      assert_difference('User.count') do
        post admin_user_create_path, obj_hash
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end

    def update(o, obj_hash)
      get admin_user_edit_path, { :id => o.id }
      assert_response :success
      assert_template 'form'
      assert_not_nil assigns(:user)
      assert_not_nil assigns(:form_id)
      assert_equal 'edit-form', assigns(:form_id)

      post admin_user_update_path, obj_hash

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end

    def destroy(o)
      assert_difference('User.count', -1) do
        post admin_user_delete_path, { :id => [o.id] }
      end

      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
      assert_equal '1 to 3 of 3', data['itemscount']
    end
  end
end
