module DesignationHelper
  DEFAULT_SORT_COLUMN = 'title'
  DEFAULT_SORT_DIR = 'ASC'
  
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = Designation.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = Designation.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
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
  
  def self.get_filter_by(find, keyword, pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    criteria, order = get_filter_criteria(find, keyword, sort)
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
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
  
  def self.item_message(keyword, pagenum, pagesize)
    total = 0
    if keyword.blank?
      total = Designation.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
      
    else
      criteria = Designation.where('title like ?', "%#{keyword}%")
      total = criteria.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
    end
  end
  
  private
  
  def self.get_filter_criteria(find, keyword, sort = nil)
    text = "%#{keyword}%"
    order = sort.present? ? sort.to_s : nil
    criteria = Designation
    
    case find
    when 1
      criteria = criteria.where('title like ?', text)
      return criteria, order
      
    when 2
      criteria = criteria.where('`desc` like ?', text)
      return criteria, order
      
    when 3
      criteria = criteria.where('note like ?', text)
      return criteria, order
      
    else
      criteria = criteria.where('title like ? or `desc` like ? or note like ?', text, text, text)
      return criteria, order
    end
  end
end
