class CreateJobCategory < ActiveRecord::Migration
  def change
    create_table :job_category, { :primary_key => :id } do |t|
      t.integer :id, :null => false
      t.string :name, :null => false
    end
    
    add_index :job_category, [:name], { :name => 'name', :unique => true }
  end
end
