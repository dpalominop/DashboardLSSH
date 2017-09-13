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
    permit_params :name, :description,
                  :ip, :port,
                  :protocol_id, :type_id,
                  :system_id, :platform_id,
                  :location_id, :vendor_id,
                  :ping, :traceroute

    member_action :clone, method: :post do
      @network_element = resource.dup
      render :new, layout: false

      # ne = resource.clone!
      # redirect_to edit_admin_network_element_path( ne )
    end

    member_action :connectivity do
      ping_msg = ''
      traceroute_msg = ''
      resource.update(ping: "Cargando", traceroute: "Cargando")
      Server.all.each do |server|
        ping = server.ping(hostname: resource.ip)
        ping_msg += server.ip + ': \n'
        ping_msg += ping + '\n'

        traceroute = server.traceroute(hostname: resource.ip)
        traceroute_msg += server.ip + ': \n'
        traceroute_msg += traceroute + '\n'
      end
      resource.update(ping: ping_msg, traceroute: traceroute_msg)

      respond_to do |format|
        msg = { :status => "ok", :message => "Success!" }
        format.json  { render :json => msg }
      end
    end

    action_item :clone, :only => :show do
      link_to("Make a Copy", clone_admin_network_element_path(id: network_element.id))
    end

    action_item :connectivity, :only => :show do
      a "Connectivity", :id => 'connectivity'
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
        column 'Location' do |ne|
            if ne.location_id then
                link_to Location.find(ne.location_id).name, admin_location_path(ne.location_id)
            end
        end
        column 'Vendor' do |ne|
            if ne.vendor_id then
                link_to Vendor.find(ne.vendor_id).name, admin_vendor_path(ne.vendor_id)
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
            f.input :location_id, as: :select, collection: Location.all, :label => 'Location'
            f.input :vendor_id, as: :select, collection: Vendor.all, :label => 'Vendor'
            f.input :name
            f.input :description
            f.input :ip
            f.input :port
            f.input :protocol_id, as: :select, collection: Protocol.all, :label => 'Protocol'
        end
        f.actions
    end

    show do
        # columns do
        #   column do
        #     panel "Networking" do
        #       button 'Ping', as: :button
        #       button 'Traceroute'
        #     end
        #   end
        #
        #   # column do
        #   #   panel "Networking" do
        #   #     button 'Traceroute'
        #   #   end
        #   # end
        # end
        panel "Networking" do
          table_for network_element, id: "network_element_table" do
            column :ping
            column :traceroute
          end
        end

        panel "Assigned Commands lists " do
            table_for CommandList.where(platform: network_element.platform_id,
                                        system:network_element.system_id,
                                        type: network_element.type_id) do
                column 'Name' do |cl|
                    link_to cl.name, admin_command_list_path(cl.id)
                end
                column :description
            end
        end
    end

    sidebar "Network Element Details", only: :show do
        attributes_table_for network_element do
            row 'Platform' do |ne|
                link_to Platform.find(ne.platform_id).name, admin_platform_path(ne.platform_id)
            end
            row 'System' do |ne|
                link_to System.find(ne.system_id).name, admin_system_path(ne.system_id)
            end
            row 'Type' do |ne|
                link_to Type.find(ne.type_id).name, admin_type_path(ne.type_id)
            end
            row 'Location' do |ne|
                if ne.location_id then
                    link_to Location.find(ne.location_id).name, admin_location_path(ne.location_id)
                end
            end
            row 'Vendor' do |ne|
                if ne.vendor_id then
                    link_to Vendor.find(ne.vendor_id).name, admin_vendor_path(ne.vendor_id)
                end
            end

            row :name
            row :description
            row :ip
            row :port
            row 'Protocol' do |ne|
                link_to Protocol.find(ne.protocol_id).name, admin_protocol_path(ne.protocol_id)
            end
        end
    end
end
