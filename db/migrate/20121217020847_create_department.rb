class CreateDepartment < ActiveRecord::Migration
  def change
    create_table :department, { :primary_key => :id } do |t|
      t.integer :id, :null => false
      t.string :name, :null => false
    end
    
    add_index :department, [:name], { :name => 'name', :unique => true }
  end
end
