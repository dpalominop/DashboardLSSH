ActiveAdmin.register Location do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 8

  permit_params :name

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.locations") do
      selectable_column
      column I18n.t("active_admin.name"), :sortable => :name do |loc|
          if loc.name then
              link_to loc.name, admin_location_path(loc.id)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |loc|
          if loc.created_at then
              loc.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |loc|
          if loc.updated_at then
              loc.updated_at
          end
      end
      actions
  end

  form do |f|
      f.inputs do
          f.input :name, :label => I18n.t("active_admin.location")
      end
      f.actions
  end
end
