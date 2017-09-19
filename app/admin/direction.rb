ActiveAdmin.register Direction do
  menu :label => I18n.t("active_admin.directions"),
       :parent => I18n.t("active_admin.employee_management"),
       :priority => 2
  permit_params :name, :description, :vice_presidency_id
end
