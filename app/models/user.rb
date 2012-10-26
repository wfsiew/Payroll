require 'digest'

class User < ActiveRecord::Base
  attr_accessible :username, :pwd, :pwd_confirmation
  attr_accessor :pwd
  
  self.table_name = 'user'
  
  validates :username, :uniqueness => { :message => 'user.unique.username' },
                       :length => { :within => 3..50, :message => 'user.tooshort.username' }
  validates :pwd, :confirmation => { :message => 'user.confirmation.password' },
                  :length => { :within => 4..20, :message => 'user.tooshort.password' },
                  :presence => { :message => 'user.blank.password' },
                  :if => :password_required?
                  
  before_save :encrypt_new_password
  
  UNCHANGED_PASSWORD = '********'
                       
  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.authenticated?(password)
      return username
    end
  end
  
  def authenticated?(password)
    self.password == encrypt(password)
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
