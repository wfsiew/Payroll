class CreatePayRate < ActiveRecord::Migration
  def change
    create_table :pay_rate, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.string :staff_id, :null => false
      t.integer :month, :null => false
      t.integer :year, :null => false
      t.float :hourly_pay_rate, :null => false
    end
    
    change_column :pay_rate, :id, :string, :limit => 40
  end
end
