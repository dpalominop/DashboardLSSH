ActiveAdmin.register Role do
  menu :label => I18n.t("active_admin.roles"),
       :parent => I18n.t("active_admin.employee_management")

  permit_params :name
end
