class AddColumnToCommandList < ActiveRecord::Migration[5.1]
  def change
    add_column :command_lists, :all_commands, :bool
  end
end
