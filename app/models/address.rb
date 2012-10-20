class Address
  include ActiveModel::Validations
  
  attr_accessor :street, :city, :state, :postalcode, :country
  
  validates_presence_of :street, :message => 'address.blank.street'
  validates_presence_of :city, :message => 'address.blank.city'
  validates_presence_of :state, :message => 'address.blank.state'
  validates_presence_of :postalcode, :message => 'address.blank.postalcode'
  validates_presence_of :country, :message => 'address.blank.country'
  
  def initialize(street, city, state, postalcode, country)
    @street, @city, @state, @postalcode, @country = street, city, state, postalcode, country
  end
end