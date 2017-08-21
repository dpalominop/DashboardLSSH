ActiveAdmin.register Type do
  menu :parent => "Security Management", :priority => 6

  permit_params :name, :description, :system_id
end
