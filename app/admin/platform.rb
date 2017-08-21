ActiveAdmin.register Platform do
  menu :parent => "Security Management", :priority => 4

  permit_params :name, :description, :state_id
end
