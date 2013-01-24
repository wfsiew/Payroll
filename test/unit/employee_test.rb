require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  
  test 'should create employee' do
    o = Employee.new
    o.id = '0007'
    o.staff_id = 'S0007'
    o.first_name = 'Ken'
    o.middle_name = 'Chua'
    o.last_name = 'Leong'
    o.new_ic = '887760489'
    o.gender = 'M'
    o.marital_status = 'S'
    o.nationality = 'Malaysian'
    o.dob = Date.new(1987, 9, 6)
    o.place_of_birth = 'PJ'
    o.race = 'Chinese'
    o.religion = 'Buddhist'
    o.is_bumi = false
    o.user_id = 2
  
    assert o.save
  end
  
  test 'should find employee' do
    id = employee(:one).id
    assert_nothing_raised { Employee.find(id) }
  end
  
  test 'should update employee' do
    o = employee(:two)
    assert o.update_attributes(:new_ic => '776593367', :last_name => 'Paul')
    
    o.first_name = 'Jerry'
    assert o.save
    o = Employee.find(o.id)
    assert_equal 'Jerry', o.first_name
  end
  
  test 'should destroy employee' do
    o = employee(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Employee.find(o.id) }
  end
  
  test 'should not create a employee without required fields' do
    o = Employee.new
    assert !o.valid?
    assert o.errors[:staff_id].any?
    assert o.errors[:first_name].any?
    assert o.errors[:last_name].any?
    assert o.errors[:new_ic].any?
    assert o.errors[:gender].any?
    assert o.errors[:marital_status].any?
    assert o.errors[:nationality].any?
    assert o.errors[:dob].any?
    assert o.errors[:place_of_birth].any?
    assert o.errors[:race].any?
    
    assert_equal ['Employee ID is required'], o.errors[:staff_id]
    assert_equal ['First Name is required'], o.errors[:first_name]
    assert_equal ['Last Name is required'], o.errors[:last_name]
    assert_equal ['New IC No. is required'], o.errors[:new_ic]
    assert_equal ['Gender is required'], o.errors[:gender]
    assert_equal ['Marital Status is required'], o.errors[:marital_status]
    assert_equal ['Nationality is required'], o.errors[:nationality]
    assert_equal ['Date of Birth is required'], o.errors[:dob]
    assert_equal ['Place of Birth is required'], o.errors[:place_of_birth]
    assert_equal ['Race is required'], o.errors[:race]
  end
  
  test 'should not create a employee with duplicate staff_id' do
    o = Employee.new
    o.staff_id = 'C0002'
    assert !o.valid?
    assert o.errors[:staff_id].any?
    
    assert_equal ['Employee ID C0002 already exist'], o.errors[:staff_id]
  end
end
