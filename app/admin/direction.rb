ActiveAdmin.register Direction do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 2
  active_admin_import validate: true,
                       template: 'import' ,
                       template_object: ActiveAdminImport::Model.new(
                           hint: I18n.t("active_admin.hint_csv_import"),
                           force_encoding: :auto,
                           csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                       ),
                       headers_rewrites: { 'vice_presidency' => 'vice_presidency_id'
                                         },
                       before_batch_import: ->(importer){
                           begin
                             vice_presidency_names = importer.values_at('vice_presidency_id')
                             # replacing author name with author id
                             vice_presidencies = VicePresidency.where(name: vice_presidency_names).pluck(:name, :id)
                             options   = Hash[*vice_presidencies.flatten] # #{"Jane" => 2, "John" => 1}
                             importer.batch_replace('vice_presidency_id', options) #replacing "Jane" with 1, etc
                           rescue

                           end
                       },
                       back: -> { config.namespace.resource_for(Direction).route_collection_path }
  permit_params :name, :description, :vice_presidency_id

  controller do
    def scoped_collection
      end_of_association_chain.includes(:vice_presidency)
    end
  end

  csv do
    column :name, humanize_name: false
    column :vice_presidency, humanize_name: false  do |dir|
        dir.vice_presidency.name
    end
  end

  batch_action :destroy, confirm: I18n.t("active_admin.batch_confirm_direction")  do |ids|
    ids = ids.map { |i| i.to_i }
    batch_action_collection.find(ids.flatten).each do |resource|
      resource.destroy
    end
    if ids.size == 1 then
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_direction")
    else
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_directions")
    end
  end

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.directions") do
      selectable_column
      column I18n.t("active_admin.vice_presidency"), :sortable => 'vice_presidencies.name' do |dir|
          if dir.vice_presidency_id then
              vp = VicePresidency.find(dir.vice_presidency_id)
              link_to vp.name, admin_vice_presidency_path(vp.to_param)
          end
      end
      column I18n.t("active_admin.name"), :sortable => :name do |dir|
          if dir.name then
              link_to dir.name, admin_direction_path(dir.to_param)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |dir|
          if dir.created_at then
              dir.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |dir|
          if dir.updated_at then
              dir.updated_at
          end
      end
      actions
  end

  show do
    panel I18n.t("active_admin.direction_details") do
      attributes_table_for resource do
        row I18n.t("active_admin.direction") do |res|
            res.name
        end
        row I18n.t("active_admin.vice_presidency") do |res|
            vp = VicePresidency.find(res.vice_presidency_id)
            link_to vp.name, admin_vice_presidency_path(vp.to_param)
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
          f.input :vice_presidency_id, as: :select, collection: VicePresidency.all, :label => I18n.t("active_admin.vice_presidency")
          f.input :name, :label => I18n.t("active_admin.name")
          f.input :description, :label => I18n.t("active_admin.description")
      end
      f.actions
  end
end
