require 'securerandom'

module EmployeeHelper
  DEFAULT_SORT_COLUMN = 'staff_id'
  DEFAULT_SORT_DIR = 'ASC'
  
  # Get all employee records.
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = Employee.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    
    if sort.column == 'd.title' || sort.column == 'es.name' || 
	  sort.column == 'dept.name' || sort.column == 'e.first_name'
      criteria = get_join({}, sort)
      
    else
      criteria = Employee
    end
    
    list = criteria.order(order).all(:offset => pager.lower_bound, 
                                     :limit => pager.pagesize)
    { :item_msg => pager.item_message, 
      :hasnext => has_next, 
      :hasprev => has_prev, 
      :nextpage => pager.pagenum + 1, 
      :prevpage => pager.pagenum - 1,
      :list => list, 
      :sortcolumn => sort.column, 
      :sortdir => sort.direction,
      :page => pager.pagenum,
      :totalpage => pager.total_pages }
  end
  
  # Get filtered employee records.
  def self.get_filter_by(filters, pagenum = 1, 
    pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    criteria, order = get_filter_criteria(filters, sort)
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = criteria.order(order).all(:offset => pager.lower_bound, 
                                     :limit => pager.pagesize)
    { :item_msg => pager.item_message, 
      :hasnext => has_next, 
      :hasprev => has_prev, 
      :nextpage => pager.pagenum + 1, 
      :prevpage => pager.pagenum - 1,
      :list => list, 
      :sortcolumn => sort.column, 
      :sortdir => sort.direction,
      :page => pager.pagenum,
      :totalpage => pager.total_pages }
  end
  
  # Get the validation errors.
  def self.get_errors(errors)
    { :error => 1, :errors => errors }
  end
  
  # Get the item message text.
  def self.item_message(filters, pagenum, pagesize)
    total = 0
    if filters.blank?
      total = Employee.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
      
    else
      criteria, order = get_filter_criteria(filters)
      total = criteria.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
    end
  end
  
  # Get the employee object from the POST request.
  def self.employee_obj(params)
    q = params[:employee]
    
    _dob = q[:dob]
    dob = Date.strptime(_dob, ApplicationHelper.date_fmt) if _dob.present?
    
    Employee.new(:id => SecureRandom.uuid, :staff_id => q[:staff_id], 
                 :first_name => q[:first_name], :middle_name => q[:middle_name],
                 :last_name => q[:last_name], :new_ic => q[:new_ic], 
                 :old_ic => q[:old_ic], :passport_no => q[:passport_no],
                 :gender => q[:gender], :marital_status => q[:marital_status], 
                 :nationality => q[:nationality], :dob => dob, 
                 :place_of_birth => q[:place_of_birth], :race => q[:race], 
                 :religion => q[:religion], :is_bumi => q[:is_bumi], 
                 :user_id => q[:user_id])
  end
  
  def self.update_obj(o, params)
    q = params[:employee]
    
    _dob = q[:dob]
    dob = Date.strptime(_dob, ApplicationHelper.date_fmt) if _dob.present?
    
    o.update_attributes(:staff_id => q[:staff_id], :first_name => q[:first_name], 
                        :middle_name => q[:middle_name], :last_name => q[:last_name], 
                        :new_ic => q[:new_ic], :old_ic => q[:old_ic], 
                        :passport_no => q[:passport_no], :gender => q[:gender], 
                        :marital_status => q[:marital_status], 
                        :nationality => q[:nationality], :dob => dob, 
                        :place_of_birth => q[:place_of_birth], :race => q[:race], 
                        :religion => q[:religion], :is_bumi => q[:is_bumi], 
                        :user_id => q[:user_id])
  end
  
  # Update the employee object.
  def self.update_info(o, params)
    q = params[:employee]
    
    _dob = q[:dob]
    dob = Date.strptime(_dob, ApplicationHelper.date_fmt) if _dob.present?
    
    o.update_attributes(:first_name => q[:first_name], :middle_name => q[:middle_name],
                        :last_name => q[:last_name], :new_ic => q[:new_ic], 
                        :old_ic => q[:old_ic], :passport_no => q[:passport_no], 
                        :gender => q[:gender], :marital_status => q[:marital_status], 
                        :nationality => q[:nationality], :dob => dob, 
                        :place_of_birth => q[:place_of_birth], :race => q[:race], 
                        :religion => q[:religion], :is_bumi => q[:is_bumi])
  end
  
  private
  
  def self.get_filter_criteria(filters, sort = nil)
    employee_keyword = "%#{filters[:employee]}%"
    staff_id_keyword = "%#{filters[:staff_id]}%"
    supervisor_keyword = "%#{filters[:supervisor]}%"
    order = sort.present? ? sort.to_s : nil
    if filters[:employment_status] != 0 || filters[:designation] != 0 || 
      filters[:dept] != 0 || sort.present?
      criteria = get_join(filters, sort)
    end
    
    criteria = Employee if criteria.blank?
    
    if filters[:employee].present?
      criteria = criteria.where(
        'first_name like ? or middle_name like ? or last_name like ?',
        employee_keyword, employee_keyword, employee_keyword)
    end
    
    if filters[:staff_id].present?
      criteria = criteria.where('staff_id like ?', staff_id_keyword)
    end
    
    if filters[:employment_status] != 0
      criteria = criteria.where('es.id = ?', filters[:employment_status])
    end
    
    if filters[:designation] != 0
      criteria = criteria.where('d.id = ?', filters[:designation])
    end
    
    if filters[:dept] != 0
      criteria = criteria.where('dept.id = ?', filters[:dept])
    end
    
    return criteria, order
  end
  
  def self.get_join(filters, sort = nil)
    joinhash = {}
    
    if filters.any?
      if filters[:employment_status] != 0
        q = Employee.joins('inner join employee_job ej on employee.id = ej.id')
                    .joins(
          'inner join employment_status es on ej.employment_status_id = es.id')
        joinhash[:employment_status] = true
      end

      if filters[:designation] != 0
        if q.blank?
          q = Employee.joins('inner join employee_job ej on employee.id = ej.id')
                      .joins('inner join designation d on ej.designation_id = d.id')

        else
          q = q.joins('inner join designation d on ej.designation_id = d.id')
        end

        joinhash[:designation] = true
      end

      if filters[:dept] != 0
        if q.blank?
          q = Employee.joins('inner join employee_job ej on employee.id = ej.id')
                      .joins('inner join department dept on ej.department_id = dept.id')

        else
          q = q.joins('inner join department dept on ej.department_id = dept.id')
        end

        joinhash[:dept] = true
      end
    end
    
    if sort.present?
      if sort.column == 'd.title'
        if joinhash.has_key?(:employment_status) && !joinhash.has_key?(:designation)
           q = q.joins('left outer join designation d on ej.designation_id = d.id')
           
        elsif !joinhash.has_key?(:employment_status) && !joinhash.has_key?(:designation)
          if q.blank?
            q = Employee.joins('left outer join employee_job ej on employee.id = ej.id')
                        .joins('left outer join designation d on ej.designation_id = d.id')
                        
          else
            q = q.joins('left outer join employee_job ej on employee.id = ej.id')
                 .joins('left outer join designation d on ej.designation_id = d.id')
          end
        end
      end
      
      if sort.column == 'es.name'
        if !joinhash.has_key?(:employment_status)
          if q.blank?
            q = Employee.joins('left outer join employee_job ej on employee.id = ej.id')
                        .joins(
              'left outer join employment_status es on ej.employment_status_id = es.id')
                        
          else
            q = q.joins('left outer join employee_job ej on employee.id = ej.id')
                 .joins(
              'left outer join employment_status es on ej.employment_status_id = es.id')
          end
        end
      end
    end
    
    if sort.column == 'dept.name'
      if joinhash.has_key?(:employment_status) && !joinhash.has_key?(:dept)
        q = q.joins('left outer join department dept on ej.department_id = dept.id')
        
      elsif !joinhash.has_key?(:employment_status) && !joinhash.has_key?(:dept)
        if q.blank?
          q = Employee.joins('left outer join employee_job ej on employee.id = ej.id')
                      .joins(
            'left outer join department dept on ej.department_id = dept.id')
          
        else
          q = q.joins('left outer join employee_job ej on employee.id = ej.id')
               .joins('left outer join department dept on ej.department_id = dept.id')
        end
      end
    end
    
    q
  end
end
