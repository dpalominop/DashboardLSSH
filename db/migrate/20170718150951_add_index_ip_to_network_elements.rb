class AddIndexIpToNetworkElements < ActiveRecord::Migration[5.1]
  def change
    add_index :network_elements, :ip, unique: true
  end
end
