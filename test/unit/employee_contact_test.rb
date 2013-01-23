require 'test_helper'

class EmployeeContactTest < ActiveSupport::TestCase
  
  test 'should create employee_contact' do
    o = EmployeeContact.new
    o.id = 3
    o.address_1 = 'Jalan Maju'
    o.address_2 = 'Blok 6'
    o.address_3 = 'Taman Gembira'
    o.city = 'KL'
    o.state = 'WP'
    o.postcode = '56000'
    o.country = 'Malaysia'
    o.home_phone = '666'
    o.mobile_phone = '777'
    o.work_email = 'test@gmail.com'
    o.other_email = 'home@gmail.com'
  
    assert o.save
  end
  
  test 'should find employee_contact' do
    id = employee_contact(:one).id
    assert_nothing_raised { EmployeeContact.find(id) }
  end
  
  test 'should update employee_contact' do
    o = employee_contact(:two)
    assert o.update_attributes(:address_1 => 'Jalan Rasa', :address_2 => 'Taman Kerinchi', 
                               :address_3 => 'Taman Pinang')
    
    o.state = 'Selangor'
    assert o.save
    o = EmployeeContact.find(o.id)
    assert_equal 'Selangor', o.state
    assert_equal 'Taman Pinang', o.address_3
  end
  
  test 'should destroy employee_contact' do
    o = employee_contact(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { EmployeeContact.find(o.id) }
  end
  
  test 'should not create a employee_contact without required fields' do
    o = EmployeeContact.new
    assert !o.valid?
    assert o.errors[:address_1].any?
    assert o.errors[:city].any?
    assert o.errors[:state].any?
    assert o.errors[:postcode].any?
    assert o.errors[:country].any?
    assert o.errors[:work_email].any?
    
    assert_equal ['Address 1 is required'], o.errors[:address_1]
    assert_equal ['City is required'], o.errors[:city]
    assert_equal ['State is required'], o.errors[:state]
    assert_equal ['Postal Code is required'], o.errors[:postcode]
    assert_equal ['Country is required'], o.errors[:country]
    assert_equal ['Work Email is required'], o.errors[:work_email]
  end
end
