ActiveAdmin.register Surveillance do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 5
  active_admin_import validate: true,
                      template: 'import' ,
                      template_object: ActiveAdminImport::Model.new(
                          hint: I18n.t("active_admin.hint_csv_import"),
                          force_encoding: :auto,
                          csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                      ),
                      headers_rewrites: { 'leadership' => 'leadership_id'
                                        },
                      before_batch_import: ->(importer){
                          begin
                            leadership_names = importer.values_at('leadership_id')
                            # replacing author name with author id
                            leaderships = Leadership.where(name: leadership_names).pluck(:name, :id)
                            options   = Hash[*leaderships.flatten] # #{"Jane" => 2, "John" => 1}
                            importer.batch_replace('leadership_id', options) #replacing "Jane" with 1, etc
                          rescue

                          end
                      },
                      back: -> { config.namespace.resource_for(Surveillance).route_collection_path }
  permit_params :name, :description, :leadership_id, platform_ids: [], employee_ids: []

  member_action :pdf, method: :get do
    render(pdf: "Reporte #{resource.name}")
  end

  action_item :pdf, :only => :show do
    link_to(I18n.t("active_admin.report"), pdf_admin_surveillance_path(id: resource.to_param))
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(:leadership)
    end
  end

  csv do
    column :name, humanize_name: false
    column :leadership, humanize_name: false  do |srv|
        srv.leadership.name
    end
  end

  index :title => I18n.t("active_admin.surveillances") do
      selectable_column
      # id_column
      column I18n.t("active_admin.leadership"), :sortable => "leaderships.name" do |su|
        if su.leadership_id then
          ldr = Leadership.find(su.leadership_id)
          link_to ldr.name, admin_leadership_path(ldr.to_param)
        end
      end
      column I18n.t("active_admin.name"), :sortable => :name do |su|
          if su.name then
              link_to su.name, admin_surveillance_path(su.to_param)
          end
      end
      actions
  end

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  form do |f|
      f.inputs I18n.t("active_admin.surveillance_details") do
          f.input :leadership_id, as: :select, collection: Leadership.all, :label => I18n.t("active_admin.leadership")
          f.input :name, :label => I18n.t("active_admin.name")
          f.input :description, :label => I18n.t("active_admin.description")
          f.input :platform_ids, as: :tags, collection: Platform.all, :label => I18n.t("active_admin.platforms")
          f.input :employee_ids, as: :tags, collection: Employee.all, :label => I18n.t("active_admin.employees")
      end
      f.actions
  end

  show :title => :name do
      panel I18n.t("active_admin.platforms") do
          table_for resource.platforms do
              column I18n.t("active_admin.name") do |pl|
                  link_to pl.name, admin_platform_path(pl.to_param)
              end
          end
      end

      panel I18n.t("active_admin.employees") do
          table_for resource.employees do
              column I18n.t("active_admin.username") do |emp|
                  link_to emp.username, admin_employee_path(emp.to_param)
              end
              column I18n.t("active_admin.name") do |emp|
                  emp.name
              end
              column I18n.t("active_admin.document") do |emp|
                  emp.document
              end
          end
      end
  end

  sidebar I18n.t("active_admin.surveillance_details"), only: :show do
      attributes_table_for resource do
          row I18n.t("active_admin.name") do |res|
              res.name
          end
          row I18n.t("active_admin.description") do |res|
              res.description
          end
      end
  end
end
