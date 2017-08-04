ActiveAdmin.register Server do
  menu :parent => "System", :if => proc{ can? :manage, User}
  permit_params :hostname, :ip, :port, :username, :password
end
