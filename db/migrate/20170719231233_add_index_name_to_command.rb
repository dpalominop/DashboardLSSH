class AddIndexNameToCommand < ActiveRecord::Migration[5.1]
  def change
    add_index :commands, :name, unique: true
  end
end
