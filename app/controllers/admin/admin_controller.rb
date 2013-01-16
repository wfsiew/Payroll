# Admin base controller.
# All Admin controllers must inherit this controller.
# Admin controller sreves incoming requests from an authenticated Admin User.
class Admin::AdminController < ApplicationController
  layout false
  
  # checks whether a user is authenticated before serving any request
  before_filter :authenticate
end
