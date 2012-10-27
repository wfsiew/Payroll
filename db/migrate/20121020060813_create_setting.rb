class CreateSetting < ActiveRecord::Migration
  def change
    create_table :setting, { :primary_key => :id } do |t|
      t.integer :id, :null => false
      t.references :designation
      t.decimal :dailyallowance, :null => false, :precision => 10, :scale => 2
      t.decimal :epf, :null => false, :precision => 10, :scale => 2
      t.decimal :socso, :null => false, :precision => 10, :scale => 2
      t.decimal :incometax, :null => false, :precision => 10, :scale => 2
    end
    
    add_index :setting, [:designation_id], { :name => 'designation', :unique => true }
  end
end
