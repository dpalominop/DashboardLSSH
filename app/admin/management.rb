ActiveAdmin.register Management do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 3
  active_admin_import validate: true,
                       template: 'import' ,
                       template_object: ActiveAdminImport::Model.new(
                           hint: I18n.t("active_admin.hint_csv_import"),
                           force_encoding: :auto,
                           csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                       ),
                       headers_rewrites: { 'direction' => 'direction_id'
                                         },
                       before_batch_import: ->(importer){
                           begin
                             direction_names = importer.values_at('direction_id')
                             # replacing author name with author id
                             directions = Direction.where(name: direction_names).pluck(:name, :id)
                             options   = Hash[*directions.flatten] # #{"Jane" => 2, "John" => 1}
                             importer.batch_replace('direction_id', options) #replacing "Jane" with 1, etc
                           rescue

                           end
                       },
                       back: -> { config.namespace.resource_for(Management).route_collection_path }
  permit_params :name, :description, :direction_id

  controller do
    def scoped_collection
      end_of_association_chain.includes(:direction)
    end
  end

  csv do
    column :name, humanize_name: false
    column :direction, humanize_name: false  do |mng|
        mng.direction.name
    end
  end

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.managements") do
      selectable_column
      column I18n.t("active_admin.direction"), :sortable => "directions.name" do |mng|
          if mng.direction_id then
              dir = Direction.find(mng.direction_id)
              link_to dir.name, admin_direction_path(dir.to_param)
          end
      end
      column I18n.t("active_admin.name"), :sortable => :name do |mng|
          if mng.name then
              link_to mng.name, admin_management_path(mng.to_param)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |mng|
          if mng.created_at then
              mng.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |mng|
          if mng.updated_at then
              mng.updated_at
          end
      end
      actions
  end

  show do
    panel I18n.t("active_admin.management_details") do
      attributes_table_for resource do
        row I18n.t("active_admin.management") do |res|
            res.name
        end
        row I18n.t("active_admin.direction") do |res|
            dir = Direction.find(res.direction_id)
            link_to dir.name, admin_direction_path(dir.to_param)
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
          f.input :direction_id, as: :select, collection: Direction.all, :label => I18n.t("active_admin.direction")
          f.input :name, :label => I18n.t("active_admin.name")
          f.input :description, :label => I18n.t("active_admin.description")
      end
      f.actions
  end
end
