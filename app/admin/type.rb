ActiveAdmin.register Type do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 3
  active_admin_import validate: true,
                      template: 'import' ,
                      template_object: ActiveAdminImport::Model.new(
                          hint: I18n.t("active_admin.hint_csv_import"),
                          force_encoding: :auto,
                          csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                      ),
                      back: -> { config.namespace.resource_for(Type).route_collection_path }
  permit_params :name

  csv do
    column :name, humanize_name: false
  end

  batch_action :destroy, confirm: I18n.t("active_admin.batch_confirm_type")  do |ids|
    ids = ids.map { |i| i.to_i }
    batch_action_collection.find(ids.flatten).each do |resource|
      resource.destroy
    end
    if ids.size == 1 then
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_type")
    else
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_types")
    end
  end

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.types") do
      selectable_column
      column I18n.t("active_admin.name"), :sortable => :name do |type|
          if type.name then
              link_to type.name, admin_type_path(type.to_param)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |type|
          if type.created_at then
              type.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |type|
          if type.updated_at then
              type.updated_at
          end
      end
      actions
  end

  show do
    panel I18n.t("active_admin.type_details") do
      attributes_table_for resource do
        row I18n.t("active_admin.type") do |res|
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
          f.input :name, :label => I18n.t("active_admin.type")
      end
      f.actions
  end
end
