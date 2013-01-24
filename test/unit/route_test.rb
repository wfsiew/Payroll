require 'test_helper'

class RouteTest < ActionController::TestCase
  
  test 'should route to auth' do
    assert_routing '/login', { :controller => 'application', :action => 'new' }
    assert_routing '/auth', { :controller => 'application', :action => 'create' }
    assert_routing '/logout', { :controller => 'application', :action => 'destroy' }
  end
  
  test 'should route to admin' do
    assert_routing '/', { :controller => 'admin/admin', :action => 'index' }
    
    assert_routing '/admin/user', { :controller => 'admin/user', :action => 'index' }
    assert_routing '/admin/user/list', { :controller => 'admin/user', :action => 'list' }
    assert_routing '/admin/user/new', { :controller => 'admin/user', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/user/create' }, 
                   { :controller => 'admin/user', :action => 'create' })
    assert_routing '/admin/user/edit/1', { :controller => 'admin/user', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/user/update' }, 
                   { :controller => 'admin/user', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/user/delete'}, 
                   { :controller => 'admin/user', :action => 'destroy' })
                   
    assert_routing '/admin/employee', { :controller => 'admin/employee', :action => 'index' }
    assert_routing '/admin/employee/list', { :controller => 'admin/employee', :action => 'list' }
    assert_routing '/admin/employee/new', { :controller => 'admin/employee', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/employee/create' }, 
                   { :controller => 'admin/employee', :action => 'create' })
    assert_routing '/admin/employee/edit/1', { :controller => 'admin/employee', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/employee/update' }, 
                   { :controller => 'admin/employee', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/employee/delete'}, 
                   { :controller => 'admin/employee', :action => 'destroy' })
                   
    assert_routing '/admin/designation', { :controller => 'admin/designation', :action => 'index' }
    assert_routing '/admin/designation/list', { :controller => 'admin/designation', :action => 'list' }
    assert_routing '/admin/designation/new', { :controller => 'admin/designation', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/designation/create' }, 
                   { :controller => 'admin/designation', :action => 'create' })
    assert_routing '/admin/designation/edit/1', { :controller => 'admin/designation', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/designation/update' }, 
                   { :controller => 'admin/designation', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/designation/delete'}, 
                   { :controller => 'admin/designation', :action => 'destroy' })
                   
    assert_routing '/admin/empstatus', { :controller => 'admin/employment_status', :action => 'index' }
    assert_routing '/admin/empstatus/list', { :controller => 'admin/employment_status', :action => 'list' }
    assert_routing '/admin/empstatus/new', { :controller => 'admin/employment_status', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/empstatus/create' }, 
                   { :controller => 'admin/employment_status', :action => 'create' })
    assert_routing '/admin/empstatus/edit/1', { :controller => 'admin/employment_status', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/empstatus/update' }, 
                   { :controller => 'admin/employment_status', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/empstatus/delete'}, 
                   { :controller => 'admin/employment_status', :action => 'destroy' })
                   
    assert_routing '/admin/jobcat', { :controller => 'admin/job_category', :action => 'index' }
    assert_routing '/admin/jobcat/list', { :controller => 'admin/job_category', :action => 'list' }
    assert_routing '/admin/jobcat/new', { :controller => 'admin/job_category', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/jobcat/create' }, 
                   { :controller => 'admin/job_category', :action => 'create' })
    assert_routing '/admin/jobcat/edit/1', { :controller => 'admin/job_category', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/jobcat/update' }, 
                   { :controller => 'admin/job_category', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/jobcat/delete'}, 
                   { :controller => 'admin/job_category', :action => 'destroy' })
                   
    assert_routing '/admin/dept', { :controller => 'admin/department', :action => 'index' }
    assert_routing '/admin/dept/list', { :controller => 'admin/department', :action => 'list' }
    assert_routing '/admin/dept/new', { :controller => 'admin/department', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/dept/create' }, 
                   { :controller => 'admin/department', :action => 'create' })
    assert_routing '/admin/dept/edit/1', { :controller => 'admin/department', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/dept/update' }, 
                   { :controller => 'admin/department', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/dept/delete'}, 
                   { :controller => 'admin/department', :action => 'destroy' })
                   
    assert_routing '/admin/payrate', { :controller => 'admin/pay_rate', :action => 'index' }
    assert_routing '/admin/payrate/list', { :controller => 'admin/pay_rate', :action => 'list' }
    assert_routing '/admin/payrate/new', { :controller => 'admin/pay_rate', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/payrate/create' }, 
                   { :controller => 'admin/pay_rate', :action => 'create' })
    assert_routing '/admin/payrate/edit/1', { :controller => 'admin/pay_rate', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/payrate/update' }, 
                   { :controller => 'admin/pay_rate', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/payrate/delete'}, 
                   { :controller => 'admin/pay_rate', :action => 'destroy' })
                   
    assert_routing '/admin/hourly/chart', { :controller => 'admin/hourly_payroll_chart', :action => 'index' }
    assert_routing '/admin/hourly/chart/data', { :controller => 'admin/hourly_payroll_chart', :action => 'data' }
    
    assert_routing 'admin/payslip', { :controller => 'admin/payslip', :action => 'index' }
    assert_routing 'admin/payslip/list', { :controller => 'admin/payslip', :action => 'list' }
    assert_routing 'admin/payslip/slip/1/2/2009', { :controller => 'admin/payslip', :action => 'payslip',
                                                    :id => '1', :month => '2', :year => '2009' }
                                                    
    assert_routing 'admin/att', { :controller => 'admin/attendance', :action => 'index' }
    assert_routing 'admin/att/list', { :controller => 'admin/attendance', :action => 'list' }
    
    assert_routing '/admin/overtime/rate', { :controller => 'admin/overtime_rate', :action => 'index' }
    assert_routing '/admin/overtime/rate/list', { :controller => 'admin/overtime_rate', :action => 'list' }
    assert_routing '/admin/overtime/rate/new', { :controller => 'admin/overtime_rate', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/overtime/rate/create' }, 
                   { :controller => 'admin/overtime_rate', :action => 'create' })
    assert_routing '/admin/overtime/rate/edit/1', { :controller => 'admin/overtime_rate', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/overtime/rate/update' }, 
                   { :controller => 'admin/overtime_rate', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/overtime/rate/delete'}, 
                   { :controller => 'admin/overtime_rate', :action => 'destroy' })
                   
    assert_routing '/admin/overtime/chart', { :controller => 'admin/overtime_chart', :action => 'index' }
    assert_routing '/admin/overtime/chart/data', { :controller => 'admin/overtime_chart', :action => 'data' }
    
    assert_routing '/admin/workhours/chart', { :controller => 'admin/total_work_hours_chart', :action => 'index' }
    assert_routing '/admin/workhours/chart/data', { :controller => 'admin/total_work_hours_chart', :action => 'data' }
    
    assert_routing '/admin/salaryadj', { :controller => 'admin/salary_adjustment', :action => 'index' }
    assert_routing '/admin/salaryadj/list', { :controller => 'admin/salary_adjustment', :action => 'list' }
    assert_routing '/admin/salaryadj/new', { :controller => 'admin/salary_adjustment', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/salaryadj/create' }, 
                   { :controller => 'admin/salary_adjustment', :action => 'create' })
    assert_routing '/admin/salaryadj/edit/1', { :controller => 'admin/salary_adjustment', :action => 'edit', :id => '1' }
    assert_routing({ :method => :post, :path => '/admin/salaryadj/update' }, 
                   { :controller => 'admin/salary_adjustment', :action => 'update' })
    assert_routing({ :method => :post, :path => '/admin/salaryadj/delete'}, 
                   { :controller => 'admin/salary_adjustment', :action => 'destroy' })
  end
  
  test 'should route to user' do
    assert_routing '/user/index', { :controller => 'user/user', :action => 'index' }
    
    assert_routing '/user/info', { :controller => 'user/info', :action => 'index' }
    assert_routing({ :method => :post, :path => '/user/info/update' }, 
                   { :controller => 'user/info', :action => 'update' })
                   
    assert_routing '/user/contact', { :controller => 'user/contact', :action => 'index' }
    assert_routing({ :method => :post, :path => '/user/contact/update' }, 
                   { :controller => 'user/contact', :action => 'update' })
                   
    assert_routing '/user/job', { :controller => 'user/job', :action => 'index' }
    
    assert_routing '/user/salary', { :controller => 'user/salary', :action => 'index' }
    
    assert_routing '/user/qualification', { :controller => 'user/qualification', :action => 'index' }
    assert_routing({ :method => :post, :path => '/user/qualification/update' }, 
                   { :controller => 'user/qualification', :action => 'update' })
                   
    assert_routing '/user/overtime/chart', { :controller => 'user/overtime_chart', :action => 'index' }
    assert_routing '/user/overtime/chart/data', { :controller => 'user/overtime_chart', :action => 'data' }
    
    assert_routing '/user/workhours/chart', { :controller => 'user/total_work_hours_chart', :action => 'index' }
    assert_routing '/user/workhours/chart/data', { :controller => 'user/total_work_hours_chart', :action => 'data' }
    
    assert_routing '/user/hourly/chart', { :controller => 'user/hourly_payroll_chart', :action => 'index' }
    assert_routing '/user/hourly/chart/data', { :controller => 'user/hourly_payroll_chart', :action => 'data' }
    
    assert_routing '/user/payslip', { :controller => 'user/payslip', :action => 'index' }
    assert_routing '/user/payslip/slip/1/2010', { :controller => 'user/payslip', :action => 'payslip',
                                                  :month => '1', :year => '2010' }
  end
end
