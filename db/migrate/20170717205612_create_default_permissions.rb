class CreateDefaultPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :default_permissions do |t|
      t.string :forbidden, :default => "[';', '&', '|','`','>','<', '$(', '${']"
      t.integer :warning_counter, :default => 2
      t.text :intro, :default => "== My personal intro ==\nWelcome to lssh\nType '?' or 'help' to get the list of allowed commands"
      t.string :prompt, :default => "%u@%h"
      t.integer :timer, :default => 5
      t.integer :strict, :default => 0
      t.string :history_file, :default => "/var/log/sa/"

      t.timestamps
    end
  end
end
