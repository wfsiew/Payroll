class CreateDesignation < ActiveRecord::Migration
  def change
    create_table :designation, { :id => false } do |t|
      t.primary_key :ID
      t.string :Title, :null => false
    end
    
    add_index :designation, [:Title], { :name => 'Title', :unique => true }
  end
end
