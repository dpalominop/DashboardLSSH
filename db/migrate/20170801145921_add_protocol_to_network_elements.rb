class AddProtocolToNetworkElements < ActiveRecord::Migration[5.1]
  def change
    add_reference :network_elements, :protocol, foreign_key: true
  end
end
