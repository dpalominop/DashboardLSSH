class CreateCommandListSudoCommands < ActiveRecord::Migration[5.1]
  def change
    create_table :command_list_sudo_commands do |t|
      t.references :command_list, foreign_key: true
      t.references :sudo_command, foreign_key: true

      t.timestamps
    end
  end
end
