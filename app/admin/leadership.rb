ActiveAdmin.register Leadership do
    menu :parent => I18n.t("active_admin.employee_management"),
         :priority => 4

    active_admin_import validate: true,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "Configure CSV options",
                              force_encoding: :auto,
                              csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                          ),
                          back: -> { config.namespace.resource_for(Surveillance).route_collection_path }

    permit_params :name, :description, :management_id

    filter :name, :label => I18n.t("active_admin.name")
    filter :created_at, :label => I18n.t("active_admin.created_at")
    filter :updated_at, :label => I18n.t("active_admin.updated_at")

    index :title => I18n.t("active_admin.leaderships") do
        selectable_column
        column I18n.t("active_admin.management") do |lds|
            if lds.management_id then
                link_to Management.find(lds.management_id).name, admin_management_path(lds.management_id)
            end
        end
        column I18n.t("active_admin.name"), :sortable => :name do |lds|
            if lds.name then
                link_to lds.name, admin_leadership_path(lds.id)
            end
        end
        column I18n.t("active_admin.created_at"), :sortable => :created_at do |lds|
            if lds.created_at then
                lds.created_at
            end
        end
        column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |lds|
            if lds.updated_at then
                lds.updated_at
            end
        end
        actions
    end

    form do |f|
        f.inputs do
            f.input :management_id, as: :select, collection: Management.all, :label => I18n.t("active_admin.management")
            f.input :name, :label => I18n.t("active_admin.name")
            f.input :description, :label => I18n.t("active_admin.description")
        end
        f.actions
    end
end
