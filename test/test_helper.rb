ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  self.use_transactional_fixtures = true
  set_fixture_class :employment_status => 'EmploymentStatus'
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Add more helper methods to be used by all tests here...
  def login_as(user)
    ouser = user(user)
    @request.session[:user_id] = ouser.id
    if ouser.role != User::ADMIN
      employee = ouser.employee
      @request.session[:employee_id] = employee.id
      @request.session[:staff_id] = employee.staff_id
      @request.session[:supervisor_id] = employee.id
    end
  end
end
