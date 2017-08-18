class AddLocationToPlatform < ActiveRecord::Migration[5.1]
  def change
    add_reference :platforms, :location, foreign_key: true
  end
end
