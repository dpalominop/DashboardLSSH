ActiveAdmin.register Management do
  menu :label => I18n.t("active_admin.managements"),
       :parent => I18n.t("active_admin.employee_management"),
       :priority => 3
  permit_params :name, :description, :direction_id
end
