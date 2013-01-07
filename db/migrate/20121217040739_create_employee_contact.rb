class CreateEmployeeContact < ActiveRecord::Migration
  def change
    create_table :employee_contact, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.string :address_1, :null => false
      t.string :address_2
      t.string :address_3
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :postcode, :null => false
      t.string :country, :null => false
      t.string :home_phone
      t.string :mobile_phone
      t.string :work_email, :null => false
      t.string :other_email
    end
    
    change_column :employee_contact, :id, :string, :limit => 40
  end
end
