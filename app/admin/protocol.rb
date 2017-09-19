ActiveAdmin.register Protocol do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 3

  permit_params :name

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.protocols") do
      selectable_column
      column I18n.t("active_admin.name"), :sortable => :name do |prot|
          if prot.name then
              link_to prot.name, admin_protocol_path(prot.id)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |prot|
          if prot.created_at then
              prot.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |prot|
          if prot.updated_at then
              prot.updated_at
          end
      end
      actions
  end

  form do |f|
      f.inputs do
          f.input :name, :label => I18n.t("active_admin.protocol")
      end
      f.actions
  end
end
