ActiveAdmin.register DefaultPermission do
  menu :parent => I18n.t("active_admin.system"),
       :if => proc{ can? :manage, User}
  #permit_params :forbidden, :warning_counter, :intro, :prompt, :timer, :strict, :history_file
  permit_params :history_file, :intro
  actions :index, :update, :edit

  config.filters = false

  index :title => I18n.t("active_admin.default_permissions"), :download_links => false do
      selectable_column
      #id_column
      #column :forbidden
      #column :warning_counter
      column :intro
      #column :prompt
      #column :timer
      #column :strict
      column I18n.t("active_admin.logs_directory"), :sortable => :history_file do |dp|
          if dp.history_file then
              dp.history_file
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |dp|
          if dp.updated_at then
              dp.updated_at
          end
      end
      actions
  end

  form do |f|
      f.inputs I18n.t("active_admin.default_permissions") do
          f.input :history_file, :label => I18n.t("active_admin.logs_directory")
          f.input :intro
      end
      f.actions
  end

end
