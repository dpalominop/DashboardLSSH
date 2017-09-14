ActiveAdmin.register System do
  menu :parent => I18n.t("active_admin.security_management"), :priority => 5

  permit_params :name, :description
end
