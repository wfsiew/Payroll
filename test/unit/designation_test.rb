require 'test_helper'

class DesignationTest < ActiveSupport::TestCase
  
  test 'should create designation' do
    o = Designation.new
    o.title = 'Manager'
  
    assert o.save
  end
  
  test 'should find designation' do
    id = designation(:one).id
    assert_nothing_raised { Designation.find(id) }
  end
  
  test 'should update designation' do
    o = designation(:two)
    assert o.update_attributes(:title => 'Admin')
    
    o.title = 'Account'
    assert o.save
    o = Designation.find(o.id)
    assert_equal 'Account', o.title
  end
  
  test 'should destroy designation' do
    o = designation(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Designation.find(o.id) }
  end
  
  test 'should not create a designation without required fields' do
    o = Designation.new
    assert !o.valid?
    assert o.errors[:title].any?
    
    assert_equal ['Job Title is required'], o.errors[:title]
  end
  
  test 'should not create a designation with duplicate title' do
    o = Designation.new
    o.title = 'Admin'
    assert !o.valid?
    assert o.errors[:title].any?
    
    assert_equal ['Job Title Admin already exist'], o.errors[:title]
  end
end
