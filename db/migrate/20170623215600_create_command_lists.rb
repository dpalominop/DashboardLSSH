class CreateCommandLists < ActiveRecord::Migration[5.1]
  def change
    create_table :command_lists do |t|
      t.string :name
      t.string :description
      t.references :network_element, foreign_key: true
      t.references :role, foreign_key: true

      t.timestamps
    end
  end

  def self.down
    drop_table :command_lists
  end
end
