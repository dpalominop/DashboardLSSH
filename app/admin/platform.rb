ActiveAdmin.register Platform do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 4

  permit_params :name, :description, :state_id, surveillance_ids:[]

  index :title => I18n.t("active_admin.platforms") do
    selectable_column
    column I18n.t("active_admin.name"), :sortable => :name do |pl|
      if pl.name then
        link_to pl.name, admin_platform_path(pl.id)
      end
    end
    column I18n.t("active_admin.state"), :sortable => :state_id do |pl|
        if pl.state_id then
            State.find(pl.state_id).name
        end
    end
    actions
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
                  link_to sv.name, admin_surveillance_path(sv.id)
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
