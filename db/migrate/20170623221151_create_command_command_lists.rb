class CreateCommandCommandLists < ActiveRecord::Migration[5.1]
  def change
    create_table :command_command_lists do |t|
      t.references :command, foreign_key: true
      t.references :command_list, foreign_key: true

      t.timestamps
    end
  end

  def self.down
    drop_table :command_command_lists
  end
end
