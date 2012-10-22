module DesignationHelper
  def self.get_all(pagenum, pagesize)
    total = Designation.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = Designation.order('title').all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list }
  end
  
  def self.get_filter_by(keyword, pagenum, pagesize)
    criteria = Designation.where('title like ?', "%#{keyword}%")
    total = criteria.count
    pager = ApplicationHelper::Pager.new(total, pagenum, pagesize)
    
    has_next = pager.has_next? ? 1 : 0
    has_prev = pager.has_prev? ? 1 : 0
    list = criteria.order('title').all(:offset => pager.lower_bound, :limit => pager.pagesize)
    { :item_msg => pager.item_message, :hasnext => has_next, :hasprev => has_prev, :nextpage => pagenum + 1, :prevpage => pagenum - 1,
      :list => list }
  end
  
  def self.get_errors(errors, attr = {})
    m = {}
    errors.each do |k, v|
      if v == 'designation.unique.title'
        m[k] = I18n.t(v, :value => attr[:title])
        next
      end
      m[k] = I18n.t(v)
    end
    { :error => 1, :errors => m }
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
end
