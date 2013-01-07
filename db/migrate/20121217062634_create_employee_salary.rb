class CreateEmployeeSalary < ActiveRecord::Migration
  def change
    create_table :employee_salary, { :primary_key => 'id' } do |t|
      t.string :id, :null => false, :limit => 40
      t.decimal :salary, :null => false, :precision => 10, :scale => 2
      t.decimal :allowance, :precision => 10, :scale => 2
      t.string :bank_name, :null => false
      t.string :bank_acc_no, :null => false
      t.string :bank_acc_type, :null => false
      t.string :bank_address, :null => false
      t.string :epf_no, :null => false
      t.string :socso_no
      t.string :income_tax_no
      t.integer :pay_type
      t.decimal :hourly_pay_rate, :precision => 10, :scale => 2
    end
    
    change_column :employee_salary, :id, :string, :limit => 40
  end
end
