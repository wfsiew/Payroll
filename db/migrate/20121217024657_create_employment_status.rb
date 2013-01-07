class CreateEmploymentStatus < ActiveRecord::Migration
  def change
    create_table :employment_status, { :primary_key => :id } do |t|
      t.integer :id, :null => false
      t.string :name, :null => false
    end
    
    add_index :employment_status, [:name], { :name => 'name', :unique => true }
  end
end
