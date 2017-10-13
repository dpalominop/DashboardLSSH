class RemoveSurveillanceFromEmployee < ActiveRecord::Migration[5.1]
  def change
    remove_reference :employees, :surveillance, foreign_key: true
  end
end
