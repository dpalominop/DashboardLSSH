ActiveAdmin.register Protocol do
  menu :label => I18n.t("active_admin.protocols"),
       :parent => I18n.t("active_admin.security_management"),
       :priority => 3

  permit_params :name
end
