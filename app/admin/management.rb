ActiveAdmin.register Management do
  menu :parent => I18n.t("active_admin.employee_management"), :priority => 3
  permit_params :name, :description, :direction_id
end
