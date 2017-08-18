class RomoveLocationFromPlatform < ActiveRecord::Migration[5.1]
  def change
    remove_column :platforms, :location
  end
end
