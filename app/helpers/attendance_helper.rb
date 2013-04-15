module AttendanceHelper
  DEFAULT_SORT_COLUMN = 'work_date'
  DEFAULT_SORT_DIR = 'ASC'
  
  # Get all attendance records.
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = Attendance.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    
    if sort.column == 'e.first_name'
      criteria = get_join({}, sort)
      
    else
      criteria = Attendance
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
  
  # Get filtered attendance records.
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
  
  # Get the total hours worked
  def self.get_total_hours(filters)
    criteria = Attendance.where('year(work_date) = ? and month(work_date) = ?', 
      filters[:year], filters[:month])
    if filters[:staff_id].present?
      criteria = criteria.where('staff_id = ?', filters[:staff_id])
    end
    
    list = criteria.all
    total_hours = 0
    list.each do |o|
      to = ApplicationHelper.localtime(o.time_out.localtime)
      ti = ApplicationHelper.localtime(o.time_in.localtime)
      total_hours += (to - ti) / 3600.0
    end
    
    total_hours
  end
  
  private
  
  def self.get_filter_criteria(filters, sort = nil)
    employee_keyword = "%#{filters[:employee]}%"
    order = sort.present? ? sort.to_s : nil
    if filters[:employee].present? || sort.present?
      criteria = get_join(filters, sort)
    end
    
    criteria = Attendance if criteria.blank?
    
    if filters[:work_date].present?
      criteria = criteria.where('work_date = ?', filters[:work_date])
    end
    
    if filters[:employee].present?
      criteria = criteria.where(
        'e.first_name like ? or e.middle_name like ? or e.last_name like ?',
        employee_keyword, employee_keyword, employee_keyword)
    end
    
    return criteria, order
  end
  
  def self.get_join(filters, sort = nil)
    joinhash = {}
    
    if filters.any?
      if filters[:employee].present?
        q = Attendance.joins('inner join employee e on attendance.staff_id = e.staff_id')
        joinhash[:employee] = true
      end
    end
    
    if sort.present?
      if sort.column == 'e.first_name'
        if !joinhash.has_key?(:employee)
          q = Attendance.joins(
            'left outer join employee e on attendance.staff_id = e.staff_id')
        end
      end
    end
    
    q
  end
end
