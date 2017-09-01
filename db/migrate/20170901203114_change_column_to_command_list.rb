class ChangeColumnToCommandList < ActiveRecord::Migration[5.1]
  def change
    change_column_default :command_lists, :all_commands, true
  end
end
