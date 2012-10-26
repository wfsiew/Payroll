module SettingHelper
  DEFAULT_SORT_COLUMN = 'd.title'
  DEFAULT_SORT_DIR = 'ASC'
  
  def self.get_all(pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    total = Setting.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    order = sort.to_s
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
	  criteria = Setting.joins('left outer join designation d on setting.designation_id = d.id')
    list = criteria.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list, :sortcolumn => sort.column, :sortdir => sort.direction }
  end
  
  def self.get_filter_by(keyword, pagenum = 1, pagesize = ApplicationHelper::Pager.default_page_size,
    sort = ApplicationHelper::Sort.new(DEFAULT_SORT_COLUMN, DEFAULT_SORT_DIR))
    criteria, order = get_filter_criteria(keyword, sort)
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = criteria.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list, :sortcolumn => sort.column, :sortdir => sort.direction }
  end
  
  def self.get_errors(errors, attr = {})
    m = {}
    errors.each do |k, v|
      if v == 'setting.unique.designation'
        title = Designation.find(attr[:designation_id]).title
        m[k] = I18n.t(v, :value => title)
        next
      end
      m[k] = I18n.t(v)
    end
    { :error => 1, :errors => m }
  end
  
  def self.item_message(keyword, pagenum, pagesize)
    total = 0
    if keyword.blank?
      total = Setting.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
      
    else
      criteria, order = get_filter_criteria(keyword)
      total = criteria.count
      pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
      return pager.item_message
    end
  end
  
  def self.total_deductions(setting)
    return 0.0 if setting.blank?
	  setting.epf + setting.socso + setting.incometax
  end
  
  def self.total_earnings(employee, setting)
    return employee.salary if setting.blank?
	  employee.salary + setting.dailyallowance
  end
  
  def self.nett_salary(employee, setting)
    total_earnings(employee, setting) - total_deductions(setting)
  end
  
  private
  
  def self.get_filter_criteria(keyword, sort = nil)
    text = "%#{keyword}%"
	  criteria = Setting.joins('inner join designation d on setting.designation_id = d.id')
	  criteria = criteria.where('d.title like ?', text)
	  order = sort.present? ? sort.to_s : nil
	  return criteria, order
  end
end
