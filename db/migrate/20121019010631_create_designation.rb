class CreateDesignation < ActiveRecord::Migration
  def change
    create_table :designation, { :primary_key => :id } do |t|
      t.integer :id, :null => false
      t.string :title, :null => false
    end
    
    add_index :designation, [:title], { :name => 'title', :unique => true }
  end
end
