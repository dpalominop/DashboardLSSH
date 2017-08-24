class AddColumnsToNetworkElements < ActiveRecord::Migration[5.1]
  def change
    add_reference :network_elements, :platform, foreign_key: true
    add_reference :network_elements, :system, foreign_key: true
  end
end
