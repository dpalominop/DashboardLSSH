class AddVendorToPlatform < ActiveRecord::Migration[5.1]
  def change
    add_reference :platforms, :vendor, foreign_key: true
  end
end
