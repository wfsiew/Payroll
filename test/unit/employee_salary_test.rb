require 'test_helper'

class EmployeeSalaryTest < ActiveSupport::TestCase
  
  test 'should create employee_salary' do
    o = EmployeeSalary.new
    o.id = 3
    o.salary = 5000
    o.allowance = 40
    o.epf = 67
    o.socso = 88
    o.income_tax = 89
    o.bank_name = 'cimb'
    o.bank_acc_no = '67886554'
    o.bank_acc_type = 'savings'
    o.bank_address = 'klcc'
    o.epf_no = '4478966'
    o.socso_no = '5590876'
    o.income_tax_no = '667546'
    o.pay_type = 1
  
    assert o.save
  end
  
  test 'should find employee_salary' do
    id = employee_salary(:one).id
    assert_nothing_raised { EmployeeSalary.find(id) }
  end
  
  test 'should update employee_salary' do
    o = employee_salary(:two)
    assert o.update_attributes(:salary => 5500, :allowance => 56)
    
    o.bank_name = 'rhb'
    assert o.save
    o = EmployeeSalary.find(o.id)
    assert_equal 'rhb', o.bank_name
  end
  
  test 'should destroy employee_salary' do
    o = employee_salary(:one)
    o.destroy
    assert_raise(ActiveRecord::RecordNotFound) { EmployeeSalary.find(o.id) }
  end
  
  test 'should not create a employee_salary without required fields' do
    o = EmployeeSalary.new
    o.salary = -90
    o.epf = -88
    assert !o.valid?
    assert o.errors[:salary].any?
    assert o.errors[:bank_name].any?
    assert o.errors[:bank_acc_no].any?
    assert o.errors[:bank_acc_type].any?
    assert o.errors[:bank_address].any?
    assert o.errors[:epf_no].any?
    assert o.errors[:pay_type].any?
    assert o.errors[:epf].any?
    
    assert_equal ['Salary is invalid'], o.errors[:salary]
    assert_equal ['Bank Name is required'], o.errors[:bank_name]
    assert_equal ['Bank Account No. is required'], o.errors[:bank_acc_no]
    assert_equal ['Bank Account Type is required'], o.errors[:bank_acc_type]
    assert_equal ['Bank Address is required'], o.errors[:bank_address]
    assert_equal ['EPF No. is required'], o.errors[:epf_no]
    assert_equal ['Pay Type is required'], o.errors[:pay_type]
    assert_equal ['EPF Deduction is invalid'], o.errors[:epf]
  end
end
