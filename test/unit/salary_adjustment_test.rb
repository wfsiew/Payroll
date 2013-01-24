require 'test_helper'

class SalaryAdjustmentTest < ActiveSupport::TestCase
  
  test 'should create salary_adjustment' do
    o = SalaryAdjustment.new
    o.id = 5
    o.staff_id = 'S0010'
    o.inc = 60
    o.month = 9
    o.year = 2009
  
    assert o.save
  end
  
  test 'should find salary_adjustment' do
    id = salary_adjustment(:one).id
    assert_nothing_raised { SalaryAdjustment.find(id) }
  end
  
  test 'should update salary_adjustment' do
    o = salary_adjustment(:two)
    assert o.update_attributes(:inc => 70)
    
    o.month = 8
    assert o.save
    o = SalaryAdjustment.find(o.id)
    assert_equal 8, o.month
  end
  
  test 'should destroy salary_adjustment' do
    o = salary_adjustment(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { SalaryAdjustment.find(o.id) }
  end
  
  test 'should not create a salary_adjustment without required fields' do
    o = SalaryAdjustment.new
    assert !o.valid?
    assert o.errors[:staff_id].any?
    assert o.errors[:inc].any?
    assert o.errors[:month].any?
    assert o.errors[:year].any?
    
    assert_equal ['Staff ID is required'], o.errors[:staff_id]
    assert_equal ['Month is required', 'Month is invalid', 'Month is invalid'], o.errors[:month]
    assert_equal ['Year is required', 'Year is invalid'], o.errors[:year]
    
    o.inc = -9
    o.month = 13
    o.year = 0
    assert !o.valid?
    
    assert_equal ['Increment is invalid'], o.errors[:inc]
    assert_equal ['Month is invalid'], o.errors[:month]
    assert_equal ['Year is invalid'], o.errors[:year]
  end
end
