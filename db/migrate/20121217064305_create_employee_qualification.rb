class CreateEmployeeQualification < ActiveRecord::Migration
  def change
    create_table :employee_qualification, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.integer :level, :null => false
      t.string :institute, :null => false
      t.string :major
      t.integer :year, :null => false
      t.decimal :gpa, :precision => 10, :scale => 2
      t.date :start_date, :null => false
      t.date :end_date, :null => false
    end
    
    change_column :employee_qualification, :id, :string, :limit => 40
  end
end
