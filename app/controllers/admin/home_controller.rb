class Admin::HomeController < Admin::AdminController
  layout 'admin'
  
  def index
    respond_to do |fmt|
      fmt.html
    end
  end
end
