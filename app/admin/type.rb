ActiveAdmin.register Type do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 6

  permit_params :name

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.types") do
      selectable_column
      column I18n.t("active_admin.name"), :sortable => :name do |type|
          if type.name then
              link_to type.name, admin_type_path(type.id)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |type|
          if type.created_at then
              type.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |type|
          if type.updated_at then
              type.updated_at
          end
      end
      actions
  end

  form do |f|
      f.inputs do
          f.input :name, :label => I18n.t("active_admin.type")
      end
      f.actions
  end
end
