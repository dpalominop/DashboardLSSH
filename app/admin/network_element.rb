ActiveAdmin.register NetworkElement do
    menu :parent => "Security Management", :priority => 4
    #menu :priority => 3
    active_admin_import validate: true,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "Configure CSV options",
                              force_encoding: :auto,
                              csv_options: { col_sep: ";", row_sep: nil, quote_char: nil }
                          )
    permit_params :name, :description, :ip, :port, :protocol_id, area_ids: []

    index :title => "Network Elements" do
        selectable_column
        #id_column
        column 'Name' do |ne|
            if ne.name then
                link_to ne.name, admin_network_element_path(ne.id)
            end
        end
        column :description
        column :ip
        column :port
        column 'Protocol' do |ne|
            if ne.protocol_id then
                link_to Protocol.find(ne.protocol_id).name, admin_protocol_path(ne.protocol_id)
            end
        end
        actions
    end

    filter :name
    filter :description
    filter :ip
    filter :port
    # filter :protocol_id

    form do |f|
        f.inputs "Network Element Details" do
            f.input :name
            f.input :description
            f.input :ip
            f.input :port
            f.input :protocol_id, as: :select, collection: Protocol.all, :label => 'Protocol'
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
            row :protocol_id
        end
    end
end
