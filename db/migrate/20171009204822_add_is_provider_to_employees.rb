class AddIsProviderToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :is_provider, :boolean
  end
end
