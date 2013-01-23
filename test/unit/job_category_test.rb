require 'test_helper'

class JobCategoryTest < ActiveSupport::TestCase
  
  test 'should create job_category' do
    o = JobCategory.new
    o.name = 'Technical'
  
    assert o.save
  end
  
  test 'should find job_category' do
    id = job_category(:one).id
    assert_nothing_raised { JobCategory.find(id) }
  end
  
  test 'should update job_category' do
    o = job_category(:two)
    assert o.update_attributes(:name => 'QC')
    
    o.name = 'Support'
    assert o.save
    o = JobCategory.find(o.id)
    assert_equal 'Support', o.name
  end
  
  test 'should destroy job_category' do
    o = job_category(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { JobCategory.find(o.id) }
  end
  
  test 'should not create a job_category without required fields' do
    o = JobCategory.new
    assert !o.valid?
    assert o.errors[:name].any?
    
    assert_equal ['Name is required'], o.errors[:name]
  end
  
  test 'should not create a job_category with duplicate name' do
    o = JobCategory.new
    o.name = 'Marketing'
    assert !o.valid?
    assert o.errors[:name].any?
    
    assert_equal ['Category Marketing already exist'], o.errors[:name]
  end
end
