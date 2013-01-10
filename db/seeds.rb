require 'securerandom'

def clear_data
  EmployeeJob.delete_all
  Designation.delete_all
  Department.delete_all
  JobCategory.delete_all
  EmploymentStatus.delete_all
  PayRate.delete_all
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

def init
  o = create_employee(:staff_id => 'S0001', :first_name => 'Ben', :last_name => 'Ng', :new_ic => '77665544',
                      :gender => 'M', :marital_status => 'S', :dob => Date.new(1988, 6, 5), :place_of_birth => 'PJ')
  des = create_designation('Software Developer')
  dept = create_dept('R&D')
  jobcat = create_job_cat('Software Development')
  empstat = create_employment_status('Probation')
  empstat = create_employment_status('Confirmed')
  empjob = create_job(:id => o.id, :designation_id => des.id, :department_id => dept.id, :employment_status_id => empstat.id,
                      :job_category_id => jobcat.id, :join_date => Date.new(2012, 1, 1), :confirm_date => Date.new(2012, 3, 1))
                        
  o = create_employee(:staff_id => 'S0002', :first_name => 'Ken', :last_name => 'Lee', :new_ic => '785400',
                      :gender => 'M', :marital_status => 'S', :dob => Date.new(1986, 6, 5), :place_of_birth => 'PJ')
  o = create_employee(:staff_id => 'S0003', :first_name => 'Steve', :last_name => 'Yap', :new_ic => '65098765',
                      :gender => 'M', :marital_status => 'S', :dob => Date.new(1974, 6, 5), :place_of_birth => 'PJ')
                        
  create_payrate('S0001')
  create_payrate('S0002')
  create_payrate('S0003')
end

clear_data
init
