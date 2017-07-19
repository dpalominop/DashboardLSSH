class AddIndexNameToSudoCommand < ActiveRecord::Migration[5.1]
  def change
    add_index :sudo_commands, :name, unique: true
  end
end
