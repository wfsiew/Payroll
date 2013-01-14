class CreateOvertimeRate < ActiveRecord::Migration
  def change
    create_table :overtime_rate do |t|
      t.float :duration
      t.integer :year
      t.float :pay_rate
    end
    
    add_index :overtime_rate, [:year], { :name => 'year', :unique => true }
  end
end
