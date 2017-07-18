class AddIndexColumnMergedToCommandLists < ActiveRecord::Migration[5.1]
  def change
    add_index :command_lists, [:network_element_id, :role_id], unique: true
  end
end
