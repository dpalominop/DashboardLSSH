class CreateLeaderships < ActiveRecord::Migration[5.1]
  def change
    create_table :leaderships do |t|
      t.string :name
      t.string :description
      t.references :management

      t.timestamps
    end
  end

  def self.down
    drop_table :leaderships
  end
end
