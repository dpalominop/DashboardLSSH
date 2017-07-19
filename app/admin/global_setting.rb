ActiveAdmin.register GlobalSetting, as: "Global Settings" do
    menu priority: 1, :parent => "System", :if => proc{ can? :manage, User}
    permit_params :logpath, :loglevel, :logfilename, :syslogname
    actions :index, :update, :edit

    config.filters = false

    index :title => "Global Settings", :download_links => false do
        selectable_column
        #id_column
        column :logpath
        column :loglevel
        column :logfilename
        #column :syslogname
        column :created_at
        actions
    end

    form do |f|
        f.inputs "Default Permissions" do
            f.input :logpath
            f.input :loglevel
            f.input :logfilename
        end
        f.actions
    end

end
