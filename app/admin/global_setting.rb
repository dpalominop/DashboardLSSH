ActiveAdmin.register GlobalSetting, as: "Global Settings" do
    menu priority: 1,
         :parent => I18n.t("active_admin.system"),
         :if => proc{ can? :manage, User}

    permit_params :logpath, :loglevel, :logfilename, :syslogname
    actions :index, :update, :edit

    config.filters = false

    index :title => I18n.t("active_admin.global_settings"), :download_links => false do
        selectable_column
        #id_column
        column I18n.t("active_admin.logpath") do |gs|
          gs.logpath
        end
        column I18n.t("active_admin.loglevel") do |gs|
          gs.loglevel
        end
        column I18n.t("active_admin.logfilename") do |gs|
          gs.logfilename
        end
        column I18n.t("active_admin.created_at") do |gs|
          gs.created_at
        end
        column I18n.t("active_admin.updated_at") do |gs|
          gs.updated_at
        end
        #column :syslogname
        actions
    end

    form do |f|
        f.inputs I18n.t("active_admin.global_settings") do
            f.input :logpath, :label => I18n.t("active_admin.logpath")
            f.input :loglevel, :label => I18n.t("active_admin.loglevel")
            f.input :logfilename, :label => I18n.t("active_admin.logfilename")
        end
        f.actions
    end

end
