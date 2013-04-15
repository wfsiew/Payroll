require 'test_helper'

class UserContactFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = user(:ben)
    @employee_contact = employee_contact(:two)
  end

  test 'view and update contact' do
    a = normal_user(UserContactFlows)
    a.logs_in @user.username, 'secret'
    a.update @employee_contact
    a.logs_out
  end

  private

  module UserContactFlows
    def update(o)
      get user_contact_path
      assert_response :success
      assert_template 'index'
      assert_not_nil assigns(:employee_contact)

      post user_contact_update_path, { 
        :employee_contact => { 
          :address_1 => o.address_1, :address_2 => o.address_2, 
          :address_3 => o.address_3, :city => o.city, :state => o.state, 
          :postcode => o.postcode, :country => o.country, :home_phone => o.home_phone, 
          :mobile_phone => o.mobile_phone, :work_email => o.work_email, 
          :other_email => o.other_email 
        },
      }
      assert_response :success
      data = JSON.parse(@response.body)
      assert_equal 1, data['success']
    end
  end
end
