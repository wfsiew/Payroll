class CreateUser < ActiveRecord::Migration
  def change
    create_table :user, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.integer :role, :null => false
      t.string :username, :null => false
      t.boolean :status, :null => false
      t.string :password, :null => false
    end
    
    add_index :user, [:username], { :name => 'username', :unique => true }
    change_column :user, :id, :string, :limit => 40
  end
end
