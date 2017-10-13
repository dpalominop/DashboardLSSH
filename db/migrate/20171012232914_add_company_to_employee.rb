class AddCompanyToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_reference :employees, :company, foreign_key: true
  end
end
