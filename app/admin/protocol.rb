ActiveAdmin.register Protocol do
  menu :parent => I18n.t("active_admin.security_management"), :priority => 3

  permit_params :name
end
