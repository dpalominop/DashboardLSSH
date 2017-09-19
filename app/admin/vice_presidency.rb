ActiveAdmin.register VicePresidency do
  menu :label => I18n.t("active_admin.vice_presidencies"),
       :parent => I18n.t("active_admin.employee_management"),
       :priority => 1
  permit_params :name, :description
end
