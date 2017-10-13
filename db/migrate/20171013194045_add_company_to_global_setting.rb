class AddCompanyToGlobalSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :global_settings, :company, :string, :default => "Telefónica"
  end
end
