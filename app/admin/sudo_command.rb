ActiveAdmin.register SudoCommand do
  #menu :parent => "Security Management", :priority => 2
  belongs_to :command_list
  permit_params :name
end
