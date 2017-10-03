class AddStateToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :status, :string
  end
end
