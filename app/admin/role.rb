ActiveAdmin.register Role do
  menu :parent => I18n.t("active_admin.employee_management")
  active_admin_import validate: true,
                      template: 'import' ,
                      template_object: ActiveAdminImport::Model.new(
                          hint: I18n.t("active_admin.hint_csv_import"),
                          force_encoding: :auto,
                          csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                      ),
                      back: -> { config.namespace.resource_for(Role).route_collection_path }
  permit_params :name

  csv do
    column :name, humanize_name: false
  end

  batch_action :destroy, confirm: I18n.t("active_admin.batch_confirm_role")  do |ids|
    ids = ids.map { |i| i.to_i }
    batch_action_collection.find(ids.flatten).each do |resource|
      resource.destroy
    end
    if ids.size == 1 then
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_role")
    else
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_roles")
    end
  end

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.roles") do
      selectable_column
      column I18n.t("active_admin.name"), :sortable => :name do |role|
          if role.name then
              link_to role.name, admin_role_path(role.to_param)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |role|
          if role.created_at then
              role.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |role|
          if role.updated_at then
              role.updated_at
          end
      end
      actions
  end

  show do
    panel I18n.t("active_admin.role_details") do
      attributes_table_for resource do
        row I18n.t("active_admin.role") do |res|
            res.name
        end
        row I18n.t("active_admin.created_at") do |res|
            res.created_at
        end
        row I18n.t("active_admin.updated_at") do |res|
            res.created_at
        end
      end
    end
  end

  form do |f|
      f.inputs do
          f.input :name, :label => I18n.t("active_admin.role")
      end
      f.actions
  end
end
