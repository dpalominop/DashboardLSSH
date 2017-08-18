class CreateSystems < ActiveRecord::Migration[5.1]
  def change
    create_table :systems do |t|
      t.string :name
      t.string :description
      t.references :platform, foreign_key: true

      t.timestamps
    end
  end
end
