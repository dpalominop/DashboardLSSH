ActiveAdmin.register NetworkElement do
    menu :parent => "Security Management", :priority => 7
    #menu :priority => 3
    active_admin_import validate: true,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "Configure CSV options",
                              force_encoding: :auto,
                              csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                          ),
                          back: -> { config.namespace.resource_for(NetworkElement).route_collection_path }
    permit_params :name, :description, :ip, :port, :protocol_id, :type_id, surveillance_ids: []

    member_action :clone, method: :post do
      @network_element = resource.dup
      render :new, layout: false

      # ne = resource.clone!
      # redirect_to edit_admin_network_element_path( ne )
    end

    action_item :clone, :only => :show do
      link_to("Make a Copy", clone_admin_network_element_path(id: network_element.id))
    end

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
        # actions
        actions defaults: true do |ne|
          link_to('Clone', clone_admin_network_element_path(id: ne.id), method: :post)
        end
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
            f.input :surveillance_ids, as: :check_boxes, collection: Surveillance.all, :label => 'Surveillances'
            f.input :type_id, as: :nested_select, minimum_input_length: 0,
                  level_1: { attribute: :platform_id, collection: Platform.all },
                  level_2: { attribute: :system_id, collection: System.all },
                  level_3: { attribute: :type_id, collection: Type.all }
        end
        f.actions
    end

    show do
        panel "Surveillances to which belongs " do
            table_for network_element.surveillances do
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
