class CreateSurveillances < ActiveRecord::Migration[5.1]
  def change
    create_table :surveillances do |t|
      t.string :name
      t.string :description
      t.references :area

      t.timestamps
    end
  end
end
