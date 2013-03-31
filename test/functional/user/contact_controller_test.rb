require 'test_helper'

class User::ContactControllerTest < ActionController::TestCase
  setup do
    @employee_contact = employee_contact(:two)
  end
  
  test "should get index" do
    login_as :ben
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:employee_contact)
  end
  
  test "should update" do
    login_as :ben
    post :update, { 
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
