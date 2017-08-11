class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.references :employee, foreign_key: true
      t.references :network_element, foreign_key: true
      t.references :server, foreign_key: true
      t.datetime   :initiation
      t.attachment :document

      t.timestamps
    end
  end
end
