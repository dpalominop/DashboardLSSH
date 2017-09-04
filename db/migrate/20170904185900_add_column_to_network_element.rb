class AddColumnToNetworkElement < ActiveRecord::Migration[5.1]
  def change
    add_reference :network_elements, :location, foreign_key: true
  end
end
