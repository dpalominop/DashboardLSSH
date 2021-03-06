ActiveAdmin.register Server do
  menu :parent => I18n.t("active_admin.system"),
       :if => proc{ can? :manage, User}
  permit_params :hostname, :ip, :port, :username, :password

  csv do
    column :hostname, humanize_name: false
    column :ip, humanize_name: false
    column :port, humanize_name: false
    column :username, humanize_name: false
  end

  batch_action :destroy, confirm: I18n.t("active_admin.batch_confirm_server")  do |ids|
    ids = ids.map { |i| i.to_i }
    batch_action_collection.find(ids.flatten).each do |resource|
      resource.destroy
    end
    if ids.size == 1 then
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_server")
    else
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_rservers")
    end
  end

  filter :hostname, :label => I18n.t("active_admin.hostname")
  filter :ip

  index :title => I18n.t("active_admin.servers") do
      selectable_column
      # id_column
      column I18n.t("active_admin.hostname"), :sortable => :hostname  do |ser|
        if ser.hostname then
          link_to ser.hostname, admin_server_path(ser.to_param)
        end
      end
      column :ip
      column I18n.t("active_admin.port"), :sortable => :port  do |ser|
          ser.port
      end
      column I18n.t("active_admin.username"), :sortable => :username  do |ser|
          ser.username
      end
      actions
  end

  show :title => :hostname do
    panel I18n.t("active_admin.server_details") do
      attributes_table_for resource do
        row I18n.t("active_admin.hostname") do |ser|
            ser.hostname
        end
        row :ip
        row I18n.t("active_admin.port") do |ser|
            ser.port
        end
        row I18n.t("active_admin.username") do |ser|
            ser.username
        end
        row I18n.t("active_admin.password") do |ser|
            ser.password
        end
        row I18n.t("active_admin.created_at") do |ser|
            ser.created_at
        end
        row I18n.t("active_admin.updated_at") do |ser|
            ser.created_at
        end
      end
    end
  end

  form do |f|
      f.inputs I18n.t("active_admin.server_details") do
          f.input :hostname, :label => I18n.t("active_admin.hostname")
          f.input :ip
          f.input :port, :label => I18n.t("active_admin.port")
          f.input :username, :label => I18n.t("active_admin.username")
          f.input :password, as: :string, :label => I18n.t("active_admin.password")
      end
      f.actions
  end
end
