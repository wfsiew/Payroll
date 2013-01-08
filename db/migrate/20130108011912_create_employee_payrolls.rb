class CreateEmployeePayrolls < ActiveRecord::Migration
  def change
    create_table :employee_payroll, { :id => false, :force => true } do |t|
      t.string :id, :null => false
      t.float :total_hours, :null => false
      t.integer :month, :null => false
      t.integer :year, :null => false
      t.float :hourly_pay_rate, :null => false
    end
  end
end
