class CreateSurveillanceNetworkElements < ActiveRecord::Migration[5.1]
  def self.up
    create_table :surveillance_network_elements do |t|
        t.references :surveillance, foreign_key: true
        t.references :network_element, foreign_key: true

        t.timestamps
    end
  end

  def self.down
    drop_table :surveillance_network_elements
  end
end
