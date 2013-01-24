require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test 'should create user' do
    o = User.new
    o.role = 1
    o.username = 'beny'
    o.status = true
    o.pwd = 'benben'
  
    assert o.save
  end
  
  test 'should find user' do
    id = user(:one).id
    assert_nothing_raised { User.find(id) }
  end
  
  test 'should update user' do
    o = user(:two)
    assert o.update_attributes(:role => 2, :status => false)
    
    o.password = 'bbb'
    assert o.save
    o = User.find(o.id)
    assert_equal 'bbb', o.password
  end
  
  test 'should destroy user' do
    o = user(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { User.find(o.id) }
  end
  
  test 'should not create a user without required fields' do
    o = User.new
    assert !o.valid?
    assert o.errors[:username].any?
    assert o.errors[:pwd].any?
    
    assert_equal ['Minimum is 3 characters'], o.errors[:username]
    assert_equal ['Minimum is 4 characters', 'Password is required'], o.errors[:pwd]
  end
  
  test 'should not create a user with duplicate username' do
    o = User.new
    o.username = 'admin'
    assert !o.valid?
    assert o.errors[:username].any?
    
    assert_equal ['Username admin already exist'], o.errors[:username]
  end
  
  test 'should not create/update user with wrong password confirmation' do
    o = User.new(:username => 'Ken', :pwd => 'hhhh', :pwd_confirmation => 'aaaa')
    assert !o.valid?
    assert o.errors[:pwd].any?
    
    assert_equal ["Password doesn't match confirmation"], o.errors[:pwd]
    
    o = user(:two)
    assert !o.update_attributes(:pwd => 'jjjj', :pwd_confirmation => 'mmmm')
    assert o.errors[:pwd].any?
    
    assert_equal ["Password doesn't match confirmation"], o.errors[:pwd]
  end
end
