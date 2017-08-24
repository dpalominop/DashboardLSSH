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
    permit_params :name, :description, :ip, :port, :protocol_id, :type_id, :system_id, :platform_id

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
        column 'Platform' do |ne|
            if ne.platform_id then
                link_to Platform.find(ne.platform_id).name, admin_platform_path(ne.platform_id)
            end
        end
        column 'System' do |ne|
            if ne.system_id then
                link_to System.find(ne.system_id).name, admin_system_path(ne.system_id)
            end
        end
        column 'Type' do |ne|
            if ne.type_id then
                link_to Type.find(ne.type_id).name, admin_type_path(ne.type_id)
            end
        end
        column 'Name' do |ne|
            if ne.name then
                link_to ne.name, admin_network_element_path(ne.id)
            end
        end
        # column :description
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
            f.input :platform_id, as: :select, collection: Platform.all, :label => 'Platform'
            f.input :system_id, as: :select, collection: System.all, :label => 'System'
            f.input :type_id, as: :select, collection: Type.all, :label => 'Type'
            f.input :name
            f.input :description
            f.input :ip
            f.input :port
            f.input :protocol_id, as: :select, collection: Protocol.all, :label => 'Protocol'
        end
        f.actions
    end

    show do
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
