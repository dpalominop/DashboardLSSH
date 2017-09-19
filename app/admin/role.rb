ActiveAdmin.register Role do
  menu :parent => I18n.t("active_admin.employee_management")

  permit_params :name
end
