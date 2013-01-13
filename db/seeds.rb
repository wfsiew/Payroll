require 'securerandom'

def clear_data
  Employee.delete_all
  EmployeeJob.delete_all
  Designation.delete_all
  Department.delete_all
  JobCategory.delete_all
  EmploymentStatus.delete_all
  PayRate.delete_all
  EmployeeSalary.delete_all
  Attendance.delete_all
end

def create_employee(x)
  o = Employee.new
  o.id = SecureRandom.uuid
  o.staff_id = x[:staff_id]
  o.first_name = x[:first_name]
  o.last_name = x[:last_name]
  o.new_ic = x[:new_ic]
  o.gender = x[:gender]
  o.marital_status = x[:marital_status]
  o.nationality = 'Malaysian'
  o.dob = x[:dob]
  o.place_of_birth = x[:place_of_birth]
  o.race = 'Chinese'
  o.is_bumi = false
  o.user_id = '0'
  o.save
  
  o
end

def create_job(x)
  o = EmployeeJob.new
  o.designation_id = x[:designation_id]
  o.department_id = x[:department_id]
  o.employment_status_id = x[:employment_status_id]
  o.job_category_id = x[:job_category_id]
  o.join_date = x[:join_date]
  o.confirm_date = x[:confirm_date]
  
  o
end

def create_designation(x)
  o = Designation.new
  o.title = x
  o.save
  
  o
end

def create_dept(x)
  o = Department.create(:name => x)
  o
end

def create_job_cat(x)
  o = JobCategory.create(:name => x)
  o
end

def create_employment_status(x)
  o = EmploymentStatus.create(:name => x)
  o
end

def create_payrate(staff_id)
  for m in (1..12)
    h = rand(40..60)
    r = rand(12..18)
    o = PayRate.create(:id => SecureRandom.uuid, :staff_id => staff_id, :total_hours => h, :month => m, :year => 2012,
                       :hourly_pay_rate => r)
  end
end

def create_salary(x)
  o = EmployeeSalary.create(:id => x[:id], :salary => x[:salary], :allowance => x[:allowance],
                            :epf => x[:epf], :socso => x[:socso], :income_tax => x[:income_tax],
                            :bank_name => x[:bank_name], :bank_acc_no => x[:bank_acc_no],
                            :bank_acc_type => x[:bank_acc_type], :bank_address => x[:bank_address],
                            :epf_no => x[:epf_no], :socso_no => x[:socso_no], :income_tax_no => x[:income_tax_no],
                            :pay_type => x[:pay_type])
  o
end

def create_overtime_rate(x)
  o = OvertimeRate.create(:duration => x[:duration], :year => x[:year], :pay_rate => x[:pay_rate])
  o
end

def create_attendance(x)
  o = Attendance.create(:id => x[:id], :employee_id => x[:employee_id], :work_date => x[:work_date], 
                        :time_in => x[:time_in], :time_out => x[:time_out])
  o
end

def create_list_attendance(x)
  t = [2, 3, 4, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 21, 22, 23, 24, 25,
       28, 29, 30, 31]
  for k in t
    ti = Time.new(2012, 1, k, 8, rand(20..59), 0)
    to = Time.new(2012, 1, k, rand(18..20), rand(0..50), 0)
    create_attendance(:id => SecureRandom.uuid, :employee_id => x[:employee_id], :work_date => Date.new(2012, 1, k), 
                      :time_in => ti, :time_out => to)
  end
end

def init
  o = create_employee(:staff_id => 'S0001', :first_name => 'Ben', :last_name => 'Ng', :new_ic => '77665544',
                      :gender => 'M', :marital_status => 'S', :dob => Date.new(1988, 6, 5), :place_of_birth => 'PJ')
  create_list_attendance(:employee_id => o.id)
  
  des = create_designation('Software Developer')
  dept = create_dept('R&D')
  jobcat = create_job_cat('Software Development')
  empstat = create_employment_status('Probation')
  empstat = create_employment_status('Confirmed')
  empjob = create_job(:id => o.id, :designation_id => des.id, :department_id => dept.id, :employment_status_id => empstat.id,
                      :job_category_id => jobcat.id, :join_date => Date.new(2012, 1, 1), :confirm_date => Date.new(2012, 3, 1))
                        
  o = create_employee(:staff_id => 'S0002', :first_name => 'Ken', :last_name => 'Lee', :new_ic => '785400',
                      :gender => 'M', :marital_status => 'S', :dob => Date.new(1986, 6, 5), :place_of_birth => 'PJ')
  create_list_attendance(:employee_id => o.id)
  
  o = create_employee(:staff_id => 'S0003', :first_name => 'Steve', :last_name => 'Yap', :new_ic => '65098765',
                      :gender => 'M', :marital_status => 'S', :dob => Date.new(1974, 6, 5), :place_of_birth => 'PJ')
  create_list_attendance(:employee_id => o.id)
                        
  create_payrate('S0001')
  create_payrate('S0002')
  create_payrate('S0003')
  
  o = create_employee(:staff_id => 'S0004', :first_name => 'Kelly', :last_name => 'Yap', :new_ic => '55441122',
                      :gender => 'F', :marital_status => 'S', :dob => Date.new(1979, 6, 5), :place_of_birth => 'KL')
  create_list_attendance(:employee_id => o.id)
  empsal = create_salary(:id => o.id, :salary => rand(2500..3000), :allowance => rand(60..100), :epf => rand(100..200),
                         :socso => rand(90..110), :income_tax => rand(100..200), :bank_name => 'RHB', :bank_acc_no => '667743290',
                         :bank_acc_type => 'savings', :bank_address => 'oug', :epf_no => '59876000', :socso_no => '76545',
                         :income_tax_no => 'ASD965777', :pay_type => 1)
end

clear_data
init
