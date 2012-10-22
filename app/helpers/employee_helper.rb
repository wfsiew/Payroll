module EmployeeHelper
  def self.get_all(pagenum, pagesize)
    total = Employee.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    criteria = Employee.joins('left outer join designation d on employee.designation_id = d.id')
    list = criteria.order('code').all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list }
  end
  
  def self.get_filter_by(find, keyword, pagenum, pagesize)
    criteria, order = get_filter_criteria(find, keyword)
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = criteria.order(order).all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list }
  end
  
  def self.get_errors(errors, attr = {})
    m = {}
    errors.each do |k, v|
      if v == 'employee.unique.code'
        m[k] = I18n.t(v, :value => attr[code])
        next
      end
      m[k] = I18n.t(v)
    end
    { :error => 1, :errors => m }
  end
  
  private
  
  def get_filter_criteria(find, keyword)
    text = "%#{keyword}%"
    
    case find
    when 1
      criteria = Employee.where('code like ?', text)
      order = 'code'
      return criteria, order
      
    when 2
      criteria = Employee.where('firstname like ?', text)
      order = 'firstname'
      return criteria, order
      
    when 3
      criteria = Employee.where('middlename like ?', text)
      order = 'middlename'
      return criteria, order
      
    when 4
      criteria = Employee.where('lastname like ?', text)
      order = 'lastname'
      return criteria, order
      
    when 5
      criteria = Employee.where('icno like ?', text)
      order = 'icno'
      return criteria, order
      
    when 6
      criteria = Employee.joins('left outer join designation d on employee.designation_id = d.id')
      criteria = criteria.where('d.title like ?', text)
      order = 'd.title'
      return criteria, order
      
    else
      criteria = Employee.joins('left outer join designation d on employee.designation_id = d.id')
      criteria = criteria.where('code like ? or firstname like ? or middlename like ? or lastname like ? or icno like ? or d.title like ?', 
                                 text, text, text, text, text, text)
      order = 'd.title'
      return criteria, order
    end
  end
end
