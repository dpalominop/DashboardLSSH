ActiveAdmin.register Type do
  menu :parent => I18n.t("active_admin.security_management"), :priority => 6

  permit_params :name, :description
end
