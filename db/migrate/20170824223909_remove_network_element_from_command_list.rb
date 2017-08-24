class RemoveNetworkElementFromCommandList < ActiveRecord::Migration[5.1]
  def change
    remove_reference :command_lists, :network_element, foreign_key: true
  end
end
