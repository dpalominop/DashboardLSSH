ActiveAdmin.register Platform do
  menu :parent => "Security Management", :priority => 4

  permit_params :name, :description, :state_id, surveillance_ids:[]

  form do |f|
      f.inputs "Platform Details" do
          f.input :name
          f.input :description
          f.input :state_id, as: :select, collection: State.all, :label => 'State'
          f.input :surveillance_ids, as: :tags, collection: Surveillance.all, :label => 'Surveillances'
      end
      f.actions
  end

  show do
      panel "Surveillances to which belongs " do
          table_for resource.surveillances do
              column :name
              column :description
          end
      end
  end

  sidebar "Platform Details", only: :show do
      attributes_table_for platform do
          row :name
          row :description
      end
  end
end
