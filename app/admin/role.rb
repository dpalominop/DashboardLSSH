ActiveAdmin.register Role do
  menu :parent => "Employee Management"

  permit_params :name
end
