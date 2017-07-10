ActiveAdmin.register NetworkElement do
    permit_params :name, :description, :ip, :port, area_ids: []

    index :title => "Network Elements" do
        selectable_column
        #id_column
        column :name
        column :description
        column :ip
        column :port
        actions
    end

    filter :name
    filter :description
    filter :ip
    filter :port

    form do |f|
        f.inputs "Network Element Details" do
            f.input :name
            f.input :description
            f.input :ip
            f.input :port
            f.input :area_ids, as: :check_boxes, collection: Area.all, :label => 'Areas'
        end
        f.actions
    end

    show do
        panel "Areas to which belongs " do
            table_for network_element.areas do
                column :name
                column :description
            end
        end

        panel "Assigned Commands lists " do
            table_for network_element.command_lists do
                column :name
                column :description
            end
        end
    end

    sidebar "Network Element Details", only: :show do
        attributes_table_for network_element do
            row :name
            row :description
            row :ip
            row :port
        end
    end
end
