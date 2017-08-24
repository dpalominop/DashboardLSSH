ActiveAdmin.register System do
  menu :parent => "Security Management", :priority => 5

  permit_params :name, :description
end
