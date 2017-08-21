ActiveAdmin.register Vendor do
  menu :parent => "Security Management", :priority => 9
  
  permit_params :name, :description
end
