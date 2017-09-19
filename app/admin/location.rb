ActiveAdmin.register Location do
  menu :label => I18n.t("active_admin.locations"),
       :parent => I18n.t("active_admin.security_management"),
       :priority => 8

  permit_params :name, :description
end
