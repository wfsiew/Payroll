module PayRateHelper
  DEFAULT_SORT_COLUMN = 'staff_id'
  DEFAULT_SORT_DIR = 'ASC'
  
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = PayRate.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = PayRate.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
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
  
  def self.get_filter_by(filters, pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    criteria, order = get_filter_criteria(filters, sort)
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = criteria.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
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
  
  def self.get_errors(errors)
    { :error => 1, :errors => errors }
  end
  
  def self.item_message(filters, pagenum, pagesize)
    total = 0
    if filters.blank?
      total = PayRate.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
      
    else
      criteria, order = get_filter_criteria(filters)
      total = criteria.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
    end
  end
  
  def self.get_pay_rate(filters)
    o = PayRate.where(:staff_id => filters[:staff_id])
               .where(:year => filters[:year])
               .where(:month => filters[:month]).first
    rate = 0
    rate = o.hourly_pay_rate if o.present?
    rate
  end
  
  private
  
  def self.get_filter_criteria(filters, sort = nil)
    staff_id_keyword = "%#{filters[:staff_id]}%"
    order = sort.present? ? sort.to_s : nil
    criteria = PayRate
    if filters[:staff_id].present?
      criteria = criteria.where('staff_id like ?', staff_id_keyword)
    end
    
    if filters[:month] != 0
      criteria = criteria.where(:month => filters[:month])
    end
    
    if filters[:year] != 0
      criteria = criteria.where(:year => filters[:year])
    end
    
    return criteria, order
  end
end
