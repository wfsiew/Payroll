class Admin::AdminController < ApplicationController
  layout false
  
  before_filter :authenticate
end
