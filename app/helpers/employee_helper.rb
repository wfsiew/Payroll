module EmployeeHelper
  DEFAULT_SORT_COLUMN = 'code'
  DEFAULT_SORT_DIR = 'ASC'
  
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = Employee.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    
    if sort.column == 'd.title'
      criteria = get_join_designation
      
    else
      criteria = Employee
    end
    
    list = criteria.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list, :sortcolumn => sort.column, :sortdir => sort.direction }
  end
  
  def self.get_filter_by(find, keyword, pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    criteria, order = get_filter_criteria(find, keyword, sort)
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = criteria.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list, :sortcolumn => sort.column, :sortdir => sort.direction }
  end
  
  def self.get_errors(errors, others = nil, attr = {})
    m = {}
    errors.each do |k, v|
      if v == 'employee.unique.code'
        m[k] = I18n.t(v, :value => attr[:code])
        next
      end
      m[k] = I18n.t(v)
    end
    
    if others.present?
      others.each do |k, v|
        m[k] = I18n.t(v)
      end
    end
    { :error => 1, :errors => m }
  end
  
  def self.item_message(find, keyword, pagenum, pagesize)
    total = 0
    if find == 0 && keyword.blank?
      total = Employee.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
      
    else
      criteria, order = get_filter_criteria(find, keyword)
      total = criteria.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
    end
  end
  
  private
  
  def self.get_filter_criteria(find, keyword, sort = nil)
    text = "%#{keyword}%"
    order = sort.present? ? sort.to_s : nil
    if (sort.present? && sort.column == 'd.title') || (find == 0 || find == 6)
      criteria = get_join_designation
      
    else
      criteria = Employee
    end
    
    case find
    when 1
      criteria = criteria.where('code like ?', text)
      return criteria, order
      
    when 2
      criteria = criteria.where('firstname like ?', text)
      return criteria, order
      
    when 3
      criteria = criteria.where('middlename like ?', text)
      return criteria, order
      
    when 4
      criteria = criteria.where('lastname like ?', text)
      return criteria, order
      
    when 5
      criteria = criteria.where('icno like ?', text)
      return criteria, order
      
    when 6
      criteria = criteria.where('d.title like ?', text)
      return criteria, order
      
    else
      criteria = criteria.where('code like ? or firstname like ? or middlename like ? or lastname like ? or icno like ? or d.title like ?', 
                                 text, text, text, text, text, text)
      return criteria, order
    end
  end
  
  def self.get_join_designation
    Employee.joins('left outer join designation d on employee.designation_id = d.id')
  end
end
