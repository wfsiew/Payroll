require 'test_helper'

class UserContactFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
    @employee_contact = employee_contact(:two)
  end

  test 'view and update contact' do
    a = normal_user(UserContactFlows)
    a.logs_in @user.username, 'secret'
    a.update
    a.logs_out
  end

  private

  module UserContactFlows
    def update
      get user_contact_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:employee_contact)

      post user_contact_update_path, { 
        :employee_contact => { 
          :address_1 => @employee_contact.address_1, :address_2 => @employee_contact.address_2, 
          :address_3 => @employee_contact.address_3, :city => @employee_contact.city, :state => @employee_contact.state, 
          :postcode => @employee_contact.postcode, :country => @employee_contact.country, :home_phone => @employee_contact.home_phone, 
          :mobile_phone => @employee_contact.mobile_phone, :work_email => @employee_contact.work_email, 
          :other_email => @employee_contact.other_email 
        },
      }
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
  end
end
