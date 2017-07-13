class CreateGlobalSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :global_settings do |t|
      t.string :logpath, :default => "/var/log/lssh/"
      t.string :loglevel, :default => "4"
      t.string :logfilename, :default => "%y%m%d-%u"
      t.string :syslogname, :default => "syslog"

      t.timestamps
    end
  end
end
