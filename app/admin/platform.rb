ActiveAdmin.register Platform do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 1
  active_admin_import validate: true,
                      template: 'import' ,
                      template_object: ActiveAdminImport::Model.new(
                          hint: I18n.t("active_admin.hint_csv_import"),
                          force_encoding: :auto,
                          csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                      ),
                      headers_rewrites: { 'state' => 'state_id'
                                        },
                      before_batch_import: ->(importer){
                          begin
                            state_names = importer.values_at('state_id')
                            states = State.where(name: state_names).pluck(:name, :id)
                            options   = Hash[*states.flatten]
                            importer.batch_replace('state_id', options)
                          rescue

                          end
                      },
                      back: -> { config.namespace.resource_for(Platform).route_collection_path }
  permit_params :name, :description, :state_id, surveillance_ids:[]

  csv do
    column :name, humanize_name: false
    column :state, humanize_name: false  do |pt|
        pt.state.name
    end
  end

  batch_action :destroy, confirm: I18n.t("active_admin.batch_confirm_platform")  do |ids|
    ids = ids.map { |i| i.to_i }
    batch_action_collection.find(ids.flatten).each do |resource|
      resource.destroy
    end
    if ids.size == 1 then
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_platform")
    else
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_platforms")
    end
  end

  index :title => I18n.t("active_admin.platforms") do
    selectable_column
    column I18n.t("active_admin.name"), :sortable => :name do |pl|
      if pl.name then
        link_to pl.name, admin_platform_path(pl.to_param)
      end
    end
    column I18n.t("active_admin.state"), :sortable => :state_id do |pl|
        if pl.state_id then
            State.find(pl.state_id).name
        end
    end
    actions
  end

  member_action :pdf, method: :get do
    render(pdf: "Reporte #{resource.name}")
  end

  action_item :pdf, :only => :show do
    link_to(I18n.t("active_admin.report"), pdf_admin_platform_path(id: resource.to_param))
  end

  filter :name, :label => I18n.t("active_admin.name")
  filter :state_id, :label => I18n.t("active_admin.state")

  form do |f|
      f.inputs I18n.t("active_admin.platform_details") do
          f.input :name, :label => I18n.t("active_admin.name")
          f.input :description, :label => I18n.t("active_admin.description")
          # f.input :vendor_id, as: :select, collection: Vendor.all, :label => 'Vendor'
          # f.input :location_id, as: :select, collection: Location.all, :label => 'Location'
          f.input :state_id, as: :select, collection: State.all, :label => I18n.t("active_admin.state")
          f.input :surveillance_ids, as: :tags, collection: Surveillance.all, :label => I18n.t("active_admin.surveillances")
      end
      f.actions
  end

  show do
      panel I18n.t("active_admin.surveillances_to_which_belongs") do
          table_for resource.surveillances do
              column I18n.t("active_admin.name") do |sv|
                if sv.name then
                  link_to sv.name, admin_surveillance_path(sv.to_param)
                end
              end
              column I18n.t("active_admin.description") do |sv|
                  sv.description
              end
          end
      end
  end

  sidebar I18n.t("active_admin.platform_details"), only: :show do
      attributes_table_for platform do
          row I18n.t("active_admin.name") do |pl|
              pl.name
          end
          row I18n.t("active_admin.description") do |pl|
              pl.description
          end
          row I18n.t("active_admin.state") do |pl|
              if pl.state_id then
                  State.find(pl.state_id).name
              end
          end
      end
  end
end
