ActiveAdmin.register Vendor do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 9

  permit_params :name, :description
end
