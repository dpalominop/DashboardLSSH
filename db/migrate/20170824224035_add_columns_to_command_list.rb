class AddColumnsToCommandList < ActiveRecord::Migration[5.1]
  def change
    add_reference :command_lists, :platform, foreign_key: true
    add_reference :command_lists, :system, foreign_key: true
    add_reference :command_lists, :type, foreign_key: true
  end
end
