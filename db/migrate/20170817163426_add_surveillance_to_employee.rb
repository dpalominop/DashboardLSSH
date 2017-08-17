class AddSurveillanceToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_reference :employees, :surveillance, foreign_key: true
  end
end
