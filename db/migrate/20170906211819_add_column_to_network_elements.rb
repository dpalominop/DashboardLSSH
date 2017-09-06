class AddColumnToNetworkElements < ActiveRecord::Migration[5.1]
  def change
    add_reference :network_elements, :vendor, foreign_key: true
  end
end
