class Admin::ChartController < Admin::AdminController
  
  def index
    respond_to do |fmt|
      fmt.html
    end
  end
end