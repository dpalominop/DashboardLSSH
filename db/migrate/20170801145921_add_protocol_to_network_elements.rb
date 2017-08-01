class AddProtocolToNetworkElements < ActiveRecord::Migration[5.1]
  def change
    add_column :network_elements, :protocol, :string
  end
end
