class CreateDesignation < ActiveRecord::Migration
  def change
    create_table :designation, { :primary_key => :id } do |t|
      t.integer :id, :null => false
      t.string :title, :null => false
      t.string :desc
      t.string :note
    end
    
    add_index :designation, [:title], { :name => 'title', :unique => true }
  end
end
