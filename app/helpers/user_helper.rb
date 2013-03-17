module UserHelper
  DEFAULT_SORT_COLUMN = 'username'
  DEFAULT_SORT_DIR = 'ASC'
  
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = User.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = User.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, 
      :hasnext => has_next, 
      :hasprev => has_prev, 
      :nextpage => pagenum + 1, 
      :prevpage => pagenum - 1,
      :list => list, 
      :sortcolumn => sort.column, 
      :sortdir => sort.direction,
      :page => pager.pagenum,
      :totalpage => pager.total_pages }
  end
  
  def self.get_filter_by(filters, pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    criteria, order = get_filter_criteria(filters, sort)
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = criteria.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, 
      :hasnext => has_next, 
      :hasprev => has_prev, 
      :nextpage => pagenum + 1, 
      :prevpage => pagenum - 1,
      :list => list, 
      :sortcolumn => sort.column, 
      :sortdir => sort.direction,
      :page => pager.pagenum,
      :totalpage => pager.total_pages }
  end
  
  def self.get_errors(errors)
    { :error => 1, :errors => errors }
  end
  
  def self.item_message(filters, pagenum, pagesize)
    total = 0
    if filters.blank?
      total = User.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
      
    else
      criteria = User.where('username like ?', "%#{keyword}%")
      total = criteria.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
    end
  end
  
  private
  
  def self.get_filter_criteria(filters, sort = nil)
    employee_keyword = "%#{filters[:employee]}%"
    username_keyword = "%#{filters[:username]}%"
    order = sort.present? ? sort.to_s : nil
    if filters[:employee].present?
      criteria = get_join(filters)
      
    else
      criteria = User
    end
    
    if filters[:username].present?
      criteria = criteria.where('username like ?', username_keyword)
    end
    
    if filters[:role] != 0
      criteria = criteria.where(:role => filters[:role])
    end
    
    if filters[:employee].present?
      criteria = criteria.where('e.first_name like ? or e.middle_name like ? or e.last_name like ?',
                                 employee_keyword, employee_keyword, employee_keyword)
    end
    
    if filters[:status] != 0
      criteria = criteria.where(:status => filters[:status] == 1 ? true : false)
    end
    
    return criteria, order
  end
  
  def self.get_join(filters)
    if filters[:employee].present?
      User.joins('inner join employee e on user.id = e.user_id')
    end
  end
end
