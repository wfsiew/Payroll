class CreateEmployee < ActiveRecord::Migration
  def change
    create_table :employee, { :primary_key => :ID } do |t|
      t.string :ID, :null => false, :limit => 40
      t.string :Code, :null => false, :limit => 10
      t.string :FirstName, :null => false
      t.string :MiddleName
      t.string :LastName
      t.string :ICNo, :null => false
      t.decimal :Salary, :null => false, :precision => 10, :scale => 2
      t.string :Street, :null => false
      t.string :City, :null => false
      t.string :State, :null => false
      t.string :PostalCode, :null => false
      t.string :Country, :null => false
      t.integer :Designation
      t.string :epfNo, :null => false
      t.string :socso, :null => false
    end
    
    add_index :employee, [:Code], { :name => 'Code', :unique => true }
    add_index :employee, [:Designation], { :name => 'Designation', :unique => false }
  end
end
