class RemoveSystemFromTypes < ActiveRecord::Migration[5.1]
  def change
    remove_reference :types, :system, foreign_key: true
  end
end
