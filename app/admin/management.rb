ActiveAdmin.register Management do
  menu :parent => "Employee Management", :priority => 3
  permit_params :name, :description, :direction_id
end
