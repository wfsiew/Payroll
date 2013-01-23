require 'test_helper'

class OvertimeRateTest < ActiveSupport::TestCase
  
  test 'should create overtime_rate' do
    o = OvertimeRate.new
    o.duration = 2
    o.year = 2009
    o.pay_rate = 89
  
    assert o.save
  end
  
  test 'should find overtime_rate' do
    id = overtime_rate(:one).id
    assert_nothing_raised { OvertimeRate.find(id) }
  end
  
  test 'should update overtime_rate' do
    o = overtime_rate(:two)
    assert o.update_attributes(:duration => 3, :year => 2007, :pay_rate => 86)
    
    o.duration = 1
    assert o.save
    o = OvertimeRate.find(o.id)
    assert_equal 1, o.duration
  end
  
  test 'should destroy overtime_rate' do
    o = overtime_rate(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { OvertimeRate.find(o.id) }
  end
  
  test 'should not create a overtime_rate without required fields' do
    o = OvertimeRate.new
    o.duration = -8
    o.pay_rate = 0
    assert !o.valid?
    assert o.errors[:duration].any?
    assert o.errors[:year].any?
    assert o.errors[:pay_rate].any?
    
    assert_equal ['Duration is invalid'], o.errors[:duration]
    assert_equal ['Year is required', 'Year is invalid'], o.errors[:year]
    assert_equal ['Pay Rate is invalid'], o.errors[:pay_rate]
  end
  
  test 'should not create a overtime_rate with duplicate year' do
    o = OvertimeRate.new
    o.year = 2008
    assert !o.valid?
    assert o.errors[:year].any?
    
    assert_equal ['Overtime rate for year 2008 already exist'], o.errors[:year]
  end
end
