class CreateProtocols < ActiveRecord::Migration[5.1]
  def change
    create_table :protocols do |t|
      t.string :name

      t.timestamps
    end
    add_index :protocols, :name, unique: true
  end
end
