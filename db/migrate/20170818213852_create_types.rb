class CreateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :types do |t|
      t.string :name
      t.string :description
      t.references :system, foreign_key: true

      t.timestamps
    end
  end
end
