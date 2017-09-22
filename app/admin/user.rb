ActiveAdmin.register User do
  menu :parent => I18n.t("active_admin.system"),
       :if => proc{ can? :manage, User}
  permit_params :email, :password, :password_confirmation, :username, :name, :role

  index :download_links => false do
    selectable_column
    #id_column
    column I18n.t("active_admin.name"), :sortable => :name do |us|
      if us.name then
        link_to us.name, admin_user_path(us.id)
      end
    end
    column I18n.t("active_admin.username"), :sortable => :username  do |us|
        us.username
    end
    column I18n.t("active_admin.email"), :sortable => :email  do |us|
        us.email
    end
    column I18n.t("active_admin.role"), :sortable => :role  do |us|
        us.role
    end
    column I18n.t("active_admin.current_sign_in_at"), :sortable => :current_sign_in_at  do |us|
        us.current_sign_in_at
    end
    column I18n.t("active_admin.sign_in_count"), :sortable => :sign_in_count  do |us|
        us.sign_in_count
    end
    column I18n.t("active_admin.username"), :sortable => :created_at  do |us|
        us.created_at
    end
    actions
  end

  filter :username, :label => I18n.t("active_admin.username")
  filter :email, :label => I18n.t("active_admin.email")
  filter :role, :label => I18n.t("active_admin.role")
  filter :current_sign_in_at, :label => I18n.t("active_admin.current_sign_in_at")
  filter :sign_in_count, :label => I18n.t("active_admin.sign_in_count")
  filter :created_at, :label => I18n.t("active_admin.created_at")

  collection_action :new_list, method: :get do
      render json: User.group_by_day(:created_at).count
  end

  form do |f|
    f.inputs I18n.t("active_admin.user_details") do
      f.input :name, :label => I18n.t("active_admin.name")
      f.input :username, :label => I18n.t("active_admin.username")
      f.input :email, :label => I18n.t("active_admin.email")
      f.input :role, as: :select, collection: User::ROLES, :label => I18n.t("active_admin.role")
      f.input :password, :label => I18n.t("active_admin.password")
#      f.input :password, :label => "New Password"
      f.input :password_confirmation, :label => I18n.t("active_admin.password_confirmation")
    end
    f.actions
  end

  show do |us|
    attributes_table do
      row I18n.t("active_admin.email") do |us|
          us.email
      end
      row I18n.t("active_admin.encrypted_password") do |us|
          us.encrypted_password
      end
      row I18n.t("active_admin.username") do |us|
          us.username
      end
      row I18n.t("active_admin.reset_password_token") do |us|
          us.reset_password_token
      end
      row I18n.t("active_admin.reset_password_sent_at") do |us|
          us.reset_password_sent_at
      end
      row I18n.t("active_admin.remember_created_at") do |us|
          us.remember_created_at
      end
      row I18n.t("active_admin.current_sign_in_at") do |us|
          us.current_sign_in_at
      end
      row I18n.t("active_admin.last_sign_in_at") do |us|
          us.last_sign_in_at
      end
      row I18n.t("active_admin.current_sign_in_ip") do |us|
          us.current_sign_in_ip
      end
      row I18n.t("active_admin.last_sign_in_ip") do |us|
          us.last_sign_in_ip
      end
      row I18n.t("active_admin.created_at") do |us|
          us.created_at
      end
      row I18n.t("active_admin.updated_at") do |us|
          us.updated_at
      end
      row I18n.t("active_admin.name") do |us|
          us.name
      end
      row I18n.t("active_admin.role") do |us|
          us.role
      end
    end
  end
end
