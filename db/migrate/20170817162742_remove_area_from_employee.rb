class RemoveAreaFromEmployee < ActiveRecord::Migration[5.1]
  def change
    remove_reference :employees, :area, index: true
  end
end
