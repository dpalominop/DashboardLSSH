class CreatePlatformSurveillances < ActiveRecord::Migration[5.1]
  def self.up
    create_table :platform_surveillances do |t|
        t.references :platform, foreign_key: true
        t.references :surveillance, foreign_key: true

        t.timestamps
    end
  end

  def self.down
    drop_table :platform_surveillances
  end
end
