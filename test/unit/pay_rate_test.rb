require 'test_helper'

class PayRateTest < ActiveSupport::TestCase
  
  test 'should create pay_rate' do
    o = PayRate.new
    o.id = 3
    o.staff_id = 'S0009'
    o.month = 8
    o.year = 2009
    o.hourly_pay_rate = 67
  
    assert o.save
  end
  
  test 'should find pay_rate' do
    id = pay_rate(:one).id
    assert_nothing_raised { PayRate.find(id) }
  end
  
  test 'should update pay_rate' do
    o = pay_rate(:two)
    assert o.update_attributes(:month => 7, :year => 2006, :hourly_pay_rate => 44)
    
    o.month = 6
    assert o.save
    o = PayRate.find(o.id)
    assert_equal 6, o.month
  end
  
  test 'should destroy pay_rate' do
    o = pay_rate(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { PayRate.find(o.id) }
  end
  
  test 'should not create a pay_rate without required fields' do
    o = PayRate.new
    assert !o.valid?
    assert o.errors[:staff_id].any?
    assert o.errors[:month].any?
    assert o.errors[:year].any?
    
    assert_equal ['Staff ID is required'], o.errors[:staff_id]
    assert_equal ['Month is required', 'Month is invalid', 'Month is invalid'], o.errors[:month]
    assert_equal ['Year is required', 'Year is invalid'], o.errors[:year]
    
    o.month = 0
    o.year = 0
    o.hourly_pay_rate = 0
    assert !o.valid?
    
    assert_equal ['Month is invalid'], o.errors[:month]
    assert_equal ['Year is invalid'], o.errors[:year]
    assert_equal ['Hourly pay rate is invalid'], o.errors[:hourly_pay_rate]
  end
end
