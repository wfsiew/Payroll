require 'test_helper'

class EmployeeQualificationTest < ActiveSupport::TestCase
  
  test 'should create employee_qualification' do
    o = EmployeeQualification.new
    o.id = 3
    o.level = 4
    o.institute = 'Informatics'
    o.major = 'Computer Science'
    o.year = 2005
    o.gpa = 3.0
    o.start_date = Date.new(2005, 8, 6)
    o.end_date = Date.new(2007, 3, 7)
  
    assert o.save
  end
  
  test 'should find employee_qualification' do
    id = employee_qualification(:one).id
    assert_nothing_raised { EmployeeQualification.find(id) }
  end
  
  test 'should update employee_qualification' do
    o = employee_qualification(:two)
    assert o.update_attributes(:level => 5)
    
    o.institute = 'UPM'
    assert o.save
    o = EmployeeQualification.find(o.id)
    assert_equal 'UPM', o.institute
  end
  
  test 'should destroy employee_qualification' do
    o = employee_qualification(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { EmployeeQualification.find(o.id) }
  end
  
  test 'should not create a department without required fields' do
    o = EmployeeQualification.new
    assert !o.valid?
    assert o.errors[:level].any?
    assert o.errors[:institute].any?
    assert o.errors[:year].any?
    assert o.errors[:start_date].any?
    assert o.errors[:end_date].any?
    
    assert_equal ['Qualification Level is required'], o.errors[:level]
    assert_equal ['Institute name is required'], o.errors[:institute]
    assert_equal ['Year obtained is required'], o.errors[:year]
    assert_equal ['Start Date is required'], o.errors[:start_date]
    assert_equal ['End Date is required'], o.errors[:end_date]
  end
end
