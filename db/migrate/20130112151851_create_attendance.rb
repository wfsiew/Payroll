class CreateAttendance < ActiveRecord::Migration
  def change
    create_table :attendance, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.string :employee_id, :null => false, :limit => 40
      t.date :work_date
      t.time :time_in
      t.time :time_out
    end
    
    change_column :attendance, :id, :string, :limit => 40
  end
end
