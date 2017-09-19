ActiveAdmin.register VicePresidency do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 1
  permit_params :name, :description
end
