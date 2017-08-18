class CreatePlatforms < ActiveRecord::Migration[5.1]
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :description
      t.string :location
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
