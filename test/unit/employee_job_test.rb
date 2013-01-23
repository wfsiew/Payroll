require 'test_helper'

class EmployeeJobTest < ActiveSupport::TestCase
  
  test 'should create employee_job' do
    o = EmployeeJob.new
    o.id = 8
    o.confirm_date = Date.new(2010, 7, 1)
    o.department_id = 1
    o.designation_id = 2
    o.employment_status_id = 3
    o.job_category_id = 4
    o.join_date = Date.new(2010, 6, 1)
    
    assert o.save
  end
  
  test 'should find employee_job' do
    id = employee_job(:one).id
    assert_nothing_raised { EmployeeJob.find(id) }
  end
  
  test 'should update employee_job' do
    o = employee_job(:two)
    assert o.update_attributes(:confirm_date => Date.new(2009, 5, 4), :department_id => 5, 
                               :designation_id => 4, :employment_status_id => 6,
                               :job_category_id => 4, :join_date => Date.new(2009, 2, 6))
    
    o.join_date = Date.new(2009, 2, 3)
    assert o.save
    o = EmployeeJob.find(o.id)
    assert_equal '2009-02-03', o.join_date.strftime('%Y-%m-%d')
  end
  
  test 'should destroy employee_job' do
    o = employee_job(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { EmployeeJob.find(o.id) }
  end
  
  test 'should not create a employee_job without required fields' do
    o = EmployeeJob.new
    assert !o.valid?
    assert o.errors[:designation_id].any?
    assert o.errors[:department_id].any?
    assert o.errors[:employment_status_id].any?
    assert o.errors[:job_category_id].any?
    assert o.errors[:join_date].any?
    
    assert_equal ['Designation is required'], o.errors[:designation_id]
    assert_equal ['Department is required'], o.errors[:department_id]
    assert_equal ['Employment Status is required'], o.errors[:employment_status_id]
    assert_equal ['Job Category is required'], o.errors[:job_category_id]
    assert_equal ['Join Date is required'], o.errors[:join_date]
  end
end
