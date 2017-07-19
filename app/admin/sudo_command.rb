ActiveAdmin.register SudoCommand do
  menu :parent => "Security Management", :priority => 2

  permit_params :name
end
