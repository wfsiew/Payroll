class CreateEmployee < ActiveRecord::Migration
  def change
    create_table :employee, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.string :code, :null => false, :limit => 10
      t.string :firstname, :null => false
      t.string :middlename
      t.string :lastname
      t.string :icno, :null => false
      t.decimal :salary, :null => false, :precision => 10, :scale => 2
      t.string :street, :null => false
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :postalcode, :null => false
      t.string :country, :null => false
      t.integer :designation_id
      t.string :epfno, :null => false
      t.string :socso, :null => false
    end
    
    add_index :employee, [:code], { :name => 'code', :unique => true }
    add_index :employee, [:designation_id], { :name => 'designation', :unique => false }
    change_column :employee, :id, :string, :limit => 40
  end
end
