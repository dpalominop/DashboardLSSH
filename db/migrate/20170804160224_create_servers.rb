class CreateServers < ActiveRecord::Migration[5.1]
  def change
    create_table :servers do |t|
      t.string :hostname
      t.string :ip
      t.integer :port
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
