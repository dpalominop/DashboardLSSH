ActiveAdmin.register Role do
  menu :parent => I18n.t("active_admin.employee_management")

  permit_params :name

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.roles") do
      selectable_column
      column I18n.t("active_admin.name"), :sortable => :name do |role|
          if role.name then
              link_to role.name, admin_role_path(role.id)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |role|
          if role.created_at then
              role.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |role|
          if role.updated_at then
              role.updated_at
          end
      end
      actions
  end

  form do |f|
      f.inputs do
          f.input :name, :label => I18n.t("active_admin.role")
      end
      f.actions
  end
end
