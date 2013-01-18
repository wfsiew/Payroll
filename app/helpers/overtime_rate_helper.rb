module OvertimeRateHelper
  DEFAULT_SORT_COLUMN = 'year'
  DEFAULT_SORT_DIR = 'ASC'
  
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = OvertimeRate.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = OvertimeRate.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, 
      :hasnext => has_next, 
      :hasprev => has_prev, 
      :nextpage => pagenum + 1, 
      :prevpage => pagenum - 1,
      :list => list, 
      :sortcolumn => sort.column, 
      :sortdir => sort.direction }
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
      :nextpage => pagenum + 1, 
      :prevpage => pagenum - 1,
      :list => list, 
      :sortcolumn => sort.column, 
      :sortdir => sort.direction }
  end
  
  def self.get_errors(errors)
    { :error => 1, :errors => errors }
  end
  
  def self.item_message(filters, pagenum, pagesize)
    total = 0
    if filters.blank?
      total = OvertimeRate.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
      
    else
      criteria, order = get_filter_criteria(filters)
      total = criteria.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
    end
  end
  
  private
  
  def self.get_filter_criteria(filters, sort = nil)
    order = sort.present? ? sort.to_s : nil
    criteria = OvertimeRate
    if filters[:year] != 0
      criteria = criteria.where(:year => filters[:year])
    end
    
    return criteria, order
  end
end
