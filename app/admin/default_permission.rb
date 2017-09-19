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
      column :history_file
      column :updated_at
      actions
  end

  form do |f|
      f.inputs I18n.t("active_admin.default_permissions") do
          f.input :history_file
          f.input :intro
      end
      f.actions
  end

end
