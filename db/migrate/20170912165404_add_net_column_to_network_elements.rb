class AddNetColumnToNetworkElements < ActiveRecord::Migration[5.1]
  def change
    add_column :network_elements, :ping, :text
    add_column :network_elements, :traceroute, :text
  end
end
