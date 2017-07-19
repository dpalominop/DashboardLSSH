class CreateSudoCommands < ActiveRecord::Migration[5.1]
  def change
    create_table :sudo_commands do |t|
      t.string :name

      t.timestamps
    end
  end
end
