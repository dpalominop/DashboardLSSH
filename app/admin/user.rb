ActiveAdmin.register User do
  menu :parent => I18n.t("active_admin.system"),
       :if => proc{ can? :manage, User}
  permit_params :email, :password, :password_confirmation, :username, :name, :role

  index :download_links => false do
    selectable_column
    #id_column
    column I18n.t("active_admin.name") do |us|
      if us.name then
        link_to us.name, admin_user_path(us.id)
      end
    end
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

  collection_action :new_list, method: :get do
      render json: User.group_by_day(:created_at).count
  end

  form do |f|
    f.inputs I18n.t("active_admin.user_details") do
      f.input :name
      f.input :username
      f.input :email
      f.input :role, as: :select, collection: User::ROLES, :label => I18n.t("active_admin.role")
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
