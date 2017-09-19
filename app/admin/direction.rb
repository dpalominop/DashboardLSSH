ActiveAdmin.register Direction do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 2
  permit_params :name, :description, :vice_presidency_id

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.directions") do
      selectable_column
      column I18n.t("active_admin.vice_presidency") do |dir|
          if dir.vice_presidency_id then
              link_to VicePresidency.find(dir.vice_presidency_id).name, admin_vice_presidency_path(dir.vice_presidency_id)
          end
      end
      column I18n.t("active_admin.name"), :sortable => :name do |dir|
          if dir.name then
              link_to dir.name, admin_direction_path(dir.id)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |dir|
          if dir.created_at then
              dir.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |dir|
          if dir.updated_at then
              dir.updated_at
          end
      end
      actions
  end

  form do |f|
      f.inputs do
          f.input :vice_presidency_id, as: :select, collection: VicePresidency.all, :label => I18n.t("active_admin.vice_presidency")
          f.input :name, :label => I18n.t("active_admin.name")
          f.input :description, :label => I18n.t("active_admin.description")
      end
      f.actions
  end
end
