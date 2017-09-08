ActiveAdmin.register Server do
  menu :parent => "System", :if => proc{ can? :manage, User}
  permit_params :hostname, :ip, :port, :username, :password

  filter :hostname
  filter :ip

  index :title => "Servers" do
      selectable_column
      # id_column
      column 'Hostname' do |ser|
        if ser.hostname then
          link_to ser.hostname, admin_server_path(ser.id)
        end
      end
      column :ip
      column :port
      column :username
      actions
  end

  form do |f|
      f.inputs "Server Details" do
          f.input :hostname
          f.input :ip
          f.input :port
          f.input :username
          f.input :password, as: :string
      end
      f.actions
  end
end
