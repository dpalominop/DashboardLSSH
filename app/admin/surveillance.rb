ActiveAdmin.register Surveillance do
  menu :parent => "Employee Management", :priority => 5
  permit_params :name, :description, :leadership_id
end
