class CreateCommandListEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :command_list_employees do |t|
      t.references :command_list, foreign_key: true
      t.references :employee, foreign_key: true
    end
  end
end
