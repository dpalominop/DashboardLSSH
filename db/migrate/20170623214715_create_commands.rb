class CreateCommands < ActiveRecord::Migration[5.1]
  def change
    create_table :commands do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :commands
  end
end
