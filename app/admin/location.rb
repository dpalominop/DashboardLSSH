ActiveAdmin.register Location do
  menu :parent => "Security Management", :priority => 8

  permit_params :name, :description
end
