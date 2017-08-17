class CreateManagements < ActiveRecord::Migration[5.1]
  def change
    create_table :managements do |t|
      t.string :name
      t.string :description
      t.references :direction

      t.timestamps
    end
  end
end
