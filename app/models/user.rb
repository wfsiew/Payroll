require 'digest'

# Model for user table.
class User < ActiveRecord::Base
  attr_accessible :id, :pwd, :role, :status, :username, :pwd_confirmation
  attr_accessor :pwd
  
  self.table_name = 'user'
  
  has_one :employee
  
  validates :username, :uniqueness => { :message => "Username %{value} already exist" },
                       :length => { :within => 3..50, 
                                    :message => "Minimum is %{count} characters" }
  validates :pwd, :confirmation => { :message => "Password doesn't match confirmation" },
                  :length => { :within => 4..20, 
                               :message => "Minimum is %{count} characters" },
                  :presence => { :message => "Password is required" },
                  :if => :password_required?
                  
  before_save :encrypt_new_password
  
  UNCHANGED_PASSWORD = '********'
  ADMIN = 1
  NORMAL_USER = 2
  
  @@roles = { 'Admin' => 1, 'Normal User' => 2 }
  @@statuses = { 'Enabled' => 1, 'Disabled' => 0 }
  
  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.authenticated?(password) && user.enabled?
      return user
    end
  end
  
  def authenticated?(password)
    self.password == encrypt(password)
  end
  
  def enabled?
    self.status == true
  end
  
  def self.roles
    @@roles
  end
  
  def self.statuses
    @@statuses
  end
  
  def role_display
    role == 1 ? 'Admin' : 'Normal User'
  end
  
  def status_display
    status == true ? 'Enabled' : 'Disabled'
  end
  
  protected
  
  def encrypt_new_password
    return if pwd.blank?
    self.password = encrypt(pwd)
  end
  
  def password_required?
    if pwd == UNCHANGED_PASSWORD
      return false
    end
    self.password.blank? || pwd.present?
  end
  
  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end
end
