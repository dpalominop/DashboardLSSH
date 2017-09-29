ActiveAdmin.register Leadership do
    menu :parent => I18n.t("active_admin.employee_management"),
         :priority => 4

    active_admin_import validate: true,
                         template: 'import' ,
                         template_object: ActiveAdminImport::Model.new(
                             hint: I18n.t("active_admin.hint_csv_import"),
                             force_encoding: :auto,
                             csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                         ),
                         headers_rewrites: { 'management' => 'management_id'
                                           },
                         before_batch_import: ->(importer){
                             begin
                               management_names = importer.values_at('management_id')
                               # replacing author name with author id
                               managements = Management.where(name: management_names).pluck(:name, :id)
                               options   = Hash[*managements.flatten] # #{"Jane" => 2, "John" => 1}
                               importer.batch_replace('management_id', options) #replacing "Jane" with 1, etc
                             rescue

                             end
                         },
                         back: -> { config.namespace.resource_for(Leadership).route_collection_path }

    permit_params :name, :description, :management_id

    controller do
      def scoped_collection
        end_of_association_chain.includes(:management)
      end
    end

    filter :name, :label => I18n.t("active_admin.name")
    filter :created_at, :label => I18n.t("active_admin.created_at")
    filter :updated_at, :label => I18n.t("active_admin.updated_at")

    index :title => I18n.t("active_admin.leaderships") do
        selectable_column
        column I18n.t("active_admin.management"), :sortable => "managements.name" do |lds|
            if lds.management_id then
                mng = Management.find(lds.management_id)
                link_to mng.name, admin_management_path(mng.to_param)
            end
        end
        column I18n.t("active_admin.name"), :sortable => :name do |lds|
            if lds.name then
                link_to lds.name, admin_leadership_path(lds.to_param)
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

    show do
      panel I18n.t("active_admin.leadership_details") do
        attributes_table_for resource do
          row I18n.t("active_admin.leadership") do |res|
              res.name
          end
          row I18n.t("active_admin.management") do |res|
              mng = Management.find(res.management_id)
              link_to mng.name, admin_management_path(mng.to_param)
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
            f.input :management_id, as: :select, collection: Management.all, :label => I18n.t("active_admin.management")
            f.input :name, :label => I18n.t("active_admin.name")
            f.input :description, :label => I18n.t("active_admin.description")
        end
        f.actions
    end
end
