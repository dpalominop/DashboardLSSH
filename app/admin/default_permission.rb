ActiveAdmin.register DefaultPermission do
  menu :parent => "System", :if => proc{ can? :manage, User}
  permit_params :forbidden, :warning_counter, :intro, :prompt, :timer, :strict, :history_file
  actions :index, :update, :edit

  config.filters = false

  index :title => "Default Permissions", :download_links => false do
      selectable_column
      #id_column
      column :forbidden
      column :warning_counter
      column :intro
      column :prompt
      column :timer
      column :strict
      column :history_file
      actions
  end

end
