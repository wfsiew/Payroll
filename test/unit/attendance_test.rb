require 'test_helper'

class AttendanceTest < ActiveSupport::TestCase
  
  test 'should create attendance' do
    o = Attendance.new
    o.id = 3
    o.staff_id = 'S0007'
    o.time_in = Time.new(2009, 4, 3, 8, 34, 0, '+08:00')
    o.time_out = Time.new(2009, 4, 3, 18, 34, 0, '+08:00')
    o.work_date = Date.new(2009, 4, 3)
  
    assert o.save
  end
  
  test 'should find attendance' do
    id = attendance(:one).id
    assert_nothing_raised { Attendance.find(id) }
  end
  
  test 'should update attendance' do
    o = attendance(:two)
    assert o.update_attributes(:staff_id => 'S0008')
    
    o.work_date = Date.new(2010, 6, 8)
    assert o.save
    o = Attendance.find(o.id)
    assert_equal '2010-06-08', o.work_date.strftime('%Y-%m-%d')
  end
  
  test 'should destroy attendance' do
    o = attendance(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Attendance.find(o.id) }
  end
  
  test 'should not create a attendance without required fields' do
    o = Attendance.new
    assert !o.valid?
    assert o.errors[:work_date].any?
    assert o.errors[:time_in].any?
    assert o.errors[:time_out].any?
    
    assert_equal ['Work date is required'], o.errors[:work_date]
    assert_equal ['Time in is required'], o.errors[:time_in]
    assert_equal ['Time out is required'], o.errors[:time_out]
  end
end
