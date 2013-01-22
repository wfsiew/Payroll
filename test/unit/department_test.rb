require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase

  test 'should create create department' do
    o = Department.new
	o.name = 'Account'
	
	assert o.save
  end
end
