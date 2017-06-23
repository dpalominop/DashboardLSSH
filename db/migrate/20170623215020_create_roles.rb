class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
