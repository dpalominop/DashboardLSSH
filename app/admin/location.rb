ActiveAdmin.register Location do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 8

  permit_params :name, :description
end
