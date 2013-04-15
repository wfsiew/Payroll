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

  def normal_user(test_module)
    open_session do |user|
      def user.logs_in(username, password)
        get login_path
        assert_response :success
        assert_template 'new'

        post_via_redirect auth_path, :username => username, :password => password

        assert_response :success
        assert_equal user_index_path, path
        assert_template 'index'
        assert_not_nil session[:user_id]
        assert_not_nil session[:employee_id]
        assert_not_nil session[:staff_id]
        assert_not_nil session[:supervisor_id]
      end

      def user.logs_out
        get_via_redirect logout_path
        assert_response :success
        assert_equal login_path, path
        assert_template 'new'
        assert_nil session[:user_id]
        assert_nil session[:employee_id]
        assert_nil session[:staff_id]
        assert_nil session[:supervisor_id]
      end

      user.extend(test_module)
      yield user if block_given?
    end
  end
  
  def admin_user(test_module)
    open_session do |user|
      def user.logs_in(username, password)
        get login_path
        assert_response :success
        assert_template 'new'
        
        post_via_redirect auth_path, :username => username, :password => password
        
        assert_response :success
        assert_equal admin_index_path, path
        assert_template 'index'
        assert_not_nil session[:user_id]
      end
      
      def user.logs_out
        get_via_redirect logout_path
        assert_response :success
        assert_equal login_path, path
        assert_template 'new'
        assert_nil session[:user_id]
      end
      
      user.extend(test_module)
      yield user if block_given?
    end
  end
end
