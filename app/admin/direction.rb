ActiveAdmin.register Direction do
  menu :parent => "Employee Management", :priority => 2
  permit_params :name, :description
end
