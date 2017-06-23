class CreateAreaNetworkElements < ActiveRecord::Migration[5.1]
  def self.up
    create_table :area_network_elements, :id => false do |t|
        t.integer :area_id
        t.integer :network_element_id
    end

    add_index :area_network_elements, [:area_id, :network_element_id]
  end

  def self.down
    drop_table :area_network_elements
  end
end
