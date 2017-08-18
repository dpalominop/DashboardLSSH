class AddTypeToNetworkElements < ActiveRecord::Migration[5.1]
  def change
    add_reference :network_elements, :type, foreign_key: true
  end
end
