class RemoveLastnameFromEmployees < ActiveRecord::Migration[5.1]
  def change
    remove_column :employees, :lastname, :string
  end
end
