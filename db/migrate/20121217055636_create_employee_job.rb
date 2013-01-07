class CreateEmployeeJob < ActiveRecord::Migration
  def change
    create_table :employee_job, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.integer :designation_id, :null => false
      t.integer :department_id, :null => false
      t.integer :employment_status_id, :null => false
      t.integer :job_category_id, :null => false
      t.date :join_date, :null => false
      t.date :confirm_date
    end
    
    change_column :employee_job, :id, :string, :limit => 40
  end
end
