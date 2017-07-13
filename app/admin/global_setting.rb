ActiveAdmin.register GlobalSetting, as: "Global Settings" do
    menu :parent => "System"
    permit_params :logpath, :loglevel, :logfilename, :syslogname
    actions :index, :update, :edit

    config.filters = false

    index :title => "Global Settings", :download_links => false do
        selectable_column
        #id_column
        column :logpath
        column :loglevel
        column :logfilename
        column :syslogname
        column :created_at
        actions
    end

end
