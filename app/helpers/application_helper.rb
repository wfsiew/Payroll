module ApplicationHelper
  # Pager object for paging purpose
  class Pager
    attr_accessor :total, :pagenum
    attr_reader :pagesize
    
    @@default_page_size = 10

    def initialize(total, pagenum, pagesize)
      @total = total
      @pagenum = pagenum
      set_pagesize(pagesize)
    end

    def pagesize=(pagesize)
      set_pagesize(pagesize)
    end
    
    # Get the paging message.
    def item_message
      Utils.item_message(total, pagenum, pagesize)
    end
    
    # Get the lower bound of the page.
    def lower_bound
      (pagenum - 1) * pagesize
    end
    
    # Get the upper bound of the page.
    def upper_bound
      upperbound = pagenum * pagesize
      if total < upperbound
        upperbound = total
      end
      upperbound
    end
    
    # Checks whether the pager has next page.
    def has_next?
      total > upper_bound ? true : false
    end
    
    # Checks whether the pager has previous page.
    def has_prev?
      lower_bound > 0 ? true : false
    end
    
    # Get the total pages.
    def total_pages
      (Float(total) / pagesize).ceil
    end
    
    # Get the default page size.
    def self.default_page_size
      @@default_page_size
    end
    
    private
    
    def set_pagesize(pagesize)
      if (total < pagesize || pagesize < 1) && total > 0
        @pagesize = total

      else
        @pagesize = pagesize
      end
    end
  end
    
  module Utils
    # Get the paging message.
    def self.item_message(total, pagenum, pagesize)
      x = (pagenum - 1) * pagesize + 1
      y = pagenum * pagesize
      
      if total < y
        y = total
      end

      if total < 1
        return ""
      end

      "#{x} to #{y} of #{total}"
    end
    
    # Checks for numeric.
    def self.numeric?(val)
      true if Float(val) rescue false
    end
  end
end
