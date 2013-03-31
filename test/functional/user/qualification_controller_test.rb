require 'test_helper'

class User::QualificationControllerTest < ActionController::TestCase
  setup do
    @employee_qualification = employee_qualification(:one)
  end
  
  test "should update" do
    login_as :ben
    post :update, { 
      :employee_qualification => { 
        :level => @employee_qualification.level, :institute => @employee_qualification.institute, 
        :major => @employee_qualification.major, :year => 2010, :gpa => @employee_qualification.gpa, 
        :start_date => '03-04-2006', :end_date => '02-04-2010'
      },
    }
    assert_response :success
    data = JSON.parse(@response.body)
    assert_equal 1, data['success']
  end
end
