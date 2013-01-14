module AttendanceHelper
  DEFAULT_SORT_COLUMN = 'work_date'
  DEFAULT_SORT_DIR = 'ASC'
  
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = Attendance.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = Attendance.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list, :sortcolumn => sort.column, :sortdir => sort.direction }
  end
  
  def self.get_filter_by(filters, pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    criteria, order = get_filter_criteria(filters, sort)
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = criteria.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list, :sortcolumn => sort.column, :sortdir => sort.direction }
  end
  
  private
  
  def self.get_filter_criteria(filters, sort = nil)
    employee_keyword = "%#{filters[:employee]}%"
    order = sort.present? ? sort.to_s : nil
    if filters[:employee].present?
      criteria = get_join
      
    else
      criteria = Attendance
    end
    
    if filters[:work_date].present?
      criteria = criteria.where('work_date = ?', filters[:work_date])
    end
    
    if filters[:employee].present?
      criteria = criteria.where('e.first_name like ? or e.middle_name like ? or e.last_name like ?',
                                 employee_keyword, employee_keyword, employee_keyword)
    end
    
    return criteria, order
  end
  
  def self.get_join
    Attendance.joins('inner join employee e on attendance.staff_id = e.staff_id')
  end
end
