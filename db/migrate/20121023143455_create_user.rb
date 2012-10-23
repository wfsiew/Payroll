class CreateUser < ActiveRecord::Migration
  def change
    create_table :user do |t|
      t.string :username, :limit => 50, :null => false
      t.string :password
    end
    
    add_index :user, [:username], { :name => 'username', :unique => true }
  end
end
