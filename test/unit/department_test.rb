require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase

  test 'should create department' do
    o = Department.new
	  o.name = 'Account'
	
	  assert o.save
  end
  
  test 'should find department' do
    id = department(:one).id
    assert_nothing_raised { Department.find(id) }
  end
  
  test 'should update department' do
    o = department(:two)
    assert o.update_attributes(:name => 'QC')
    
    o.name = 'Support'
    assert o.save
    o = Department.find(o.id)
    assert_equal 'Support', o.name
  end
  
  test 'should destroy department' do
    o = department(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Department.find(o.id) }
  end
  
  test "should not create a department without required fields" do
    o = Department.new
    assert !o.valid?
    assert o.errors[:name].any?
    
    assert_equal ['Name is required'], o.errors[:name]
  end
end
