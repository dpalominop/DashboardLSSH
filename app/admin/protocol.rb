ActiveAdmin.register Protocol do
  menu :parent => "Security Management", :priority => 3

  permit_params :name
end
