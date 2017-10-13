class CreateEmployeeSurveillances < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_surveillances do |t|
      t.references :employee, foreign_key: true
      t.references :surveillance, foreign_key: true

      t.timestamps
    end
  end
end
