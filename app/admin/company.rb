ActiveAdmin.register Company do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 7
  permit_params :name, :ruc
end
