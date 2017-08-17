class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :lastname
      t.string :username
      t.string :document
      t.references :surveillance, foreign_key: true

      t.timestamps
    end

    add_index :employees, :username, unique: true
    add_index :employees, :document, unique: true
  end
end
