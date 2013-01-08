class CreateEmployee < ActiveRecord::Migration
  def change
    create_table :employee, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.string :staff_id, :null => false
      t.string :first_name, :null => false
      t.string :middle_name
      t.string :last_name, :null => false
      t.string :new_ic, :null => false
      t.string :old_ic
      t.string :passport_no
      t.string :gender, :null => false, :limit => 1
      t.string :marital_status, :null => false, :limit => 1
      t.string :nationality, :null => false
      t.date :dob, :null => false
      t.string :place_of_birth, :null => false
      t.string :race, :null => false
      t.string :religion
      t.boolean :is_bumi, :null => false
      t.string :user_id, :limit => 40
    end
    
    add_index :employee, [:staff_id], { :name => 'staff_id', :unique => true }
    change_column :employee, :id, :string, :limit => 40
  end
end
