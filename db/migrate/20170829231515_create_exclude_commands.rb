class CreateExcludeCommands < ActiveRecord::Migration[5.1]
  def change
    create_table :exclude_commands do |t|
      t.string :name

      t.timestamps
    end
  end
end
