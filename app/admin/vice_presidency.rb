ActiveAdmin.register VicePresidency do
  menu :parent => "Employee Management", :priority => 1
  permit_params :name, :description
end
