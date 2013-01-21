class CreateSalaryAdjustment < ActiveRecord::Migration
  def change
    create_table :salary_adjustment, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.string :staff_id, :null => false
      t.float :inc, :null => false
      t.decimal :amount, :null => false, :precision => 10, :scale => 2
      t.integer :month, :null => false
      t.integer :year, :null => false
    end
    
    change_column :salary_adjustment, :id, :string, :limit => 40
  end
end
