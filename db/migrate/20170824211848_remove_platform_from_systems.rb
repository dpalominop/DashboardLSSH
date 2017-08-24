class RemovePlatformFromSystems < ActiveRecord::Migration[5.1]
  def change
    remove_reference :systems, :platform, foreign_key: true
  end
end
