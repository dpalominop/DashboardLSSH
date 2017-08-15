class AddReferenceManagementToArea < ActiveRecord::Migration[5.1]
  def change
    add_reference :areas, :management, foreign_key: true
  end
end
