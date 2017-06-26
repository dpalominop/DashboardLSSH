class CreateAreaNetworkElements < ActiveRecord::Migration[5.1]
  def self.up
    create_table :area_network_elements do |t|
        t.references :area, foreign_key: true
        t.references :network_element, foreign_key: true

        t.timestamps
    end
  end

  def self.down
    drop_table :area_network_elements
  end
end
