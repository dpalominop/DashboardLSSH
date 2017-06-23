class CreateNetworkElements < ActiveRecord::Migration[5.1]
  def change
    create_table :network_elements do |t|
      t.string :name
      t.text :description
      t.string :ip
      t.integer :port

      t.timestamps
    end
  end
end
