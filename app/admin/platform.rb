ActiveAdmin.register Platform do
  menu :parent => "Security Management", :priority => 4

  permit_params :name, :description, :state_id, surveillance_ids:[]

  index :title => "Platforms" do
    selectable_column
    column 'Name' do |pl|
      if pl.name then
        link_to pl.name, admin_platform_path(pl.id)
      end
    end
    column :description
    column 'State' do |pl|
        if pl.state_id then
            State.find(pl.state_id).name
        end
    end
    actions
  end

  filter :name
  filter :state_id

  form do |f|
      f.inputs "Platform Details" do
          f.input :name
          f.input :description
          # f.input :vendor_id, as: :select, collection: Vendor.all, :label => 'Vendor'
          # f.input :location_id, as: :select, collection: Location.all, :label => 'Location'
          f.input :state_id, as: :select, collection: State.all, :label => 'State'
          f.input :surveillance_ids, as: :tags, collection: Surveillance.all, :label => 'Surveillances'
      end
      f.actions
  end

  show do
      panel "Surveillances to which belongs " do
          table_for resource.surveillances do
              column 'Name' do |sv|
                if sv.name then
                  link_to sv.name, admin_surveillance_path(sv.id)
                end
              end
              column :description
          end
      end
  end

  sidebar "Platform Details", only: :show do
      attributes_table_for platform do
          row :name
          row :description
          row 'State' do |pl|
              if pl.state_id then
                  State.find(pl.state_id).name
              end
          end
      end
  end
end
