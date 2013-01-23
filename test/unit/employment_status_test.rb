require 'test_helper'

class EmploymentStatusTest < ActiveSupport::TestCase
  
  test 'should create employment_status' do
    o = EmploymentStatus.new
    o.name = 'Confirmed'
  
    assert o.save
  end
  
  test 'should find employment_status' do
    id = employment_status(:one).id
    assert_nothing_raised { EmploymentStatus.find(id) }
  end
  
  test 'should update employment_status' do
    o = employment_status(:two)
    assert o.update_attributes(:name => 'Temporary')
    
    o.name = 'Contract'
    assert o.save
    o = EmploymentStatus.find(o.id)
    assert_equal 'Contract', o.name
  end
  
  test 'should destroy employment_status' do
    o = employment_status(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { EmploymentStatus.find(o.id) }
  end
  
  test 'should not create a employment_status without required fields' do
    o = EmploymentStatus.new
    assert !o.valid?
    assert o.errors[:name].any?
    
    assert_equal ['Name is required'], o.errors[:name]
  end
  
  test 'should not create a employment_status with duplicate name' do
    o = EmploymentStatus.new
    o.name = 'Probation'
    assert !o.valid?
    assert o.errors[:name].any?
    
    assert_equal ['Employment Status Probation already exist'], o.errors[:name]
  end
end
