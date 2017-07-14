ActiveAdmin.register User do
  menu :parent => "System", :if => proc{ can? :manage, User}
  permit_params :email, :password, :password_confirmation, :username, :name, :role

  index :download_links => false do
    selectable_column
    #id_column
    column :name
    column :username
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :role

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :username
      f.input :email
      f.input :role, as: :select, collection: User::ROLES, :label => 'Role'
      f.input :password
#      f.input :password, :label => "New Password"
      f.input :password_confirmation
    end
    f.actions
  end

  # show title: :username do
  #     panel "Command Lists" do
  #         table_for user.command_lists do
  #             column :name
  #             column :description
  #             column 'Network Element' do |emp|
  #                 if emp.network_element_id then
  #                     link_to NetworkElement.find(emp.network_element_id).name, admin_network_element_path(emp.network_element_id)
  #                 end
  #             end
  #         end
  #     end
  # end

  # sidebar "User Details", only: :show do
  #     attributes_table_for user do
  #         row :username
  #         row :email
  #         row :encrypted_password
  #         row :reset_password_token
  #         row :reset_password_sent_at
  #         row :remember_created_at
  #         row :current_sign_in_at
  #         row :last_sign_in_at
  #         row :current_sign_in_ip
  #         row :last_sign_in_ip
  #         row :created_at
  #         row :updated_at
  #     end
  # end

end
