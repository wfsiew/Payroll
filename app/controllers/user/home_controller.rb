class User::HomeController < User::UserController
  layout 'user'
  
  def index
    respond_to do |fmt|
      fmt.html
    end
  end
end
