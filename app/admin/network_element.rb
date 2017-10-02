ActiveAdmin.register NetworkElement do
    menu :parent => I18n.t("active_admin.security_management"),
         :priority => 4
    active_admin_import validate: true,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "Configure CSV options",
                              force_encoding: :auto,
                              csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                          ),
                          headers_rewrites: { 'platform' => 'platform_id',
                                              'system' => 'system_id',
                                              'type' => 'type_id',
                                              'location' => 'location_id',
                                              'vendor' => 'vendor_id',
                                              'protocol' => 'protocol_id'
                                            },
                          before_batch_import: ->(importer){
                              begin
                                platform_names = importer.values_at('platform_id')
                                # replacing author name with author id
                                platforms = Platform.where(name: platform_names).pluck(:name, :id)
                                options   = Hash[*platforms.flatten] # #{"Jane" => 2, "John" => 1}
                                importer.batch_replace('platform_id', options) #replacing "Jane" with 1, etc

                                system_names = importer.values_at('system_id')
                                systems   = System.where(name: system_names).pluck(:name, :id)
                                options   = Hash[*systems.flatten]
                                importer.batch_replace('system_id', options)

                                type_names = importer.values_at('type_id')
                                types   = Type.where(name: type_names).pluck(:name, :id)
                                options   = Hash[*types.flatten]
                                importer.batch_replace('type_id', options)

                                location_names = importer.values_at('location_id')
                                locations   = Location.where(name: location_names).pluck(:name, :id)
                                options   = Hash[*locations.flatten]
                                importer.batch_replace('location_id', options)

                                vendor_names = importer.values_at('vendor_id')
                                vendors   = Vendor.where(name: vendor_names).pluck(:name, :id)
                                options   = Hash[*vendors.flatten]
                                importer.batch_replace('vendor_id', options)

                                protocol_names = importer.values_at('protocol_id')
                                protocols   = Protocol.where(name: protocol_names).pluck(:name, :id)
                                options   = Hash[*protocols.flatten]
                                importer.batch_replace('protocol_id', options)
                              rescue

                              end
                          },
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
        ping_msg += server.ip + ': <br>'
        ping_msg += ping + '<br>'

        traceroute = server.traceroute(hostname: resource.ip)
        traceroute_msg += server.ip + ': <br>'
        traceroute_msg += traceroute + '<br>'
      end
      resource.update(ping: ping_msg, traceroute: traceroute_msg)

      respond_to do |format|
        msg = { :status => "ok", :message => "Success!" }
        format.json  { render :json => msg }
      end
    end

    action_item :clone, :only => :show do
      link_to(I18n.t("active_admin.clone"), clone_admin_network_element_path(id: network_element.to_param), :method=> :post)
    end

    action_item :connectivity, :only => :show do
      a I18n.t("active_admin.connectivity"), :id => 'connectivity'
    end

    controller do
      def scoped_collection
        end_of_association_chain.includes(:platform, :system, :type, :location, :vendor)
      end
    end

    csv do
      column :platform, humanize_name: false  do |ne|
          ne.platform.name
      end
      column :system, humanize_name: false  do |ne|
          ne.system.name
      end
      column :type, humanize_name: false  do |ne|
          ne.type.name
      end
      column :location, humanize_name: false  do |ne|
          ne.location.name
      end
      column :vendor, humanize_name: false  do |ne|
          ne.vendor.name
      end
      column :name, humanize_name: false
      column :ip, humanize_name: false
      column :port, humanize_name: false
      column :protocol, humanize_name: false  do |ne|
          Protocol.find(ne.protocol_id).name
      end
    end

    index :title => I18n.t("active_admin.network_elements") do
        selectable_column
        #id_column
        column I18n.t("active_admin.platform"), :sortable => 'platforms.name' do |ne|
            if ne.platform_id then
                pt = Platform.find(ne.platform_id)
                link_to pt.name, admin_platform_path(pt.to_param)
            end
        end
        column I18n.t("active_admin.system"), :sortable => 'systems.name' do |ne|
            if ne.system_id then
                sys = System.find(ne.system_id)
                link_to sys.name, admin_system_path(sys.to_param)
            end
        end
        column I18n.t("active_admin.type"), :sortable => 'types.name' do |ne|
            if ne.type_id then
                tp = Type.find(ne.type_id)
                link_to tp.name, admin_type_path(tp.to_param)
            end
        end
        column I18n.t("active_admin.location"), :sortable => 'locations.name' do |ne|
            if ne.location_id then
                lc = Location.find(ne.location_id)
                link_to lc.name, admin_location_path(lc.to_param)
            end
        end
        column I18n.t("active_admin.vendor"), :sortable => 'vendors.name' do |ne|
            if ne.vendor_id then
                vn = Vendor.find(ne.vendor_id)
                link_to vn.name, admin_vendor_path(vn.to_param)
            end
        end
        column I18n.t("active_admin.name"), :sortable => :name do |ne|
            if ne.name then
                link_to ne.name, admin_network_element_path(ne.to_param)
            end
        end
        # column :description
        column :ip
        # column I18n.t("active_admin.port"), :sortable => :port do |ne|
        #     a ne.port
        # end
        # column I18n.t("active_admin.protocol"), :sortable => 'protocols.name' do |ne|
        #     if ne.protocol_id then
        #         link_to Protocol.find(ne.protocol_id).name, admin_protocol_path(ne.protocol_id)
        #     end
        # end
        # actions
        actions defaults: true do |ne|
          link_to(I18n.t("active_admin.clone"), clone_admin_network_element_path(id: ne.to_param), method: :post)
        end
    end

    filter :name, :label => I18n.t("active_admin.name")
    # filter :description, :label => I18n.t("active_admin.description")
    filter :ip
    # filter :port, :label => I18n.t("active_admin.port")
    # filter :protocol_id

    form do |f|
        f.inputs I18n.t("active_admin.network_element_details") do
            f.input :platform_id, as: :select, collection: Platform.all, :label => I18n.t("active_admin.platform")
            f.input :system_id, as: :select, collection: System.all, :label => I18n.t("active_admin.system")
            f.input :type_id, as: :select, collection: Type.all, :label => I18n.t("active_admin.type")
            f.input :location_id, as: :select, collection: Location.all, :label => I18n.t("active_admin.location")
            f.input :vendor_id, as: :select, collection: Vendor.all, :label => I18n.t("active_admin.vendor")
            f.input :name, :label => I18n.t("active_admin.name")
            f.input :description, :label => I18n.t("active_admin.description")
            f.input :ip
            f.input :port, :label => I18n.t("active_admin.port")
            f.input :protocol_id, as: :select, collection: Protocol.all, :label => I18n.t("active_admin.protocol")
        end
        f.actions
    end

    show do
        panel "Networking" do
          table_for network_element, id: "network_element_table" do
            column (:ping) { |network_element| simple_format(network_element.ping) }
            column (:traceroute) { |network_element| simple_format(network_element.traceroute) }
          end
        end

        panel I18n.t("active_admin.assigned_commands_lists") do
            table_for CommandList.where(platform: network_element.platform_id,
                                        system:network_element.system_id,
                                        type: network_element.type_id) do
                column I18n.t("active_admin.name") do |cl|
                    link_to cl.name, admin_command_list_path(cl.to_param)
                end
                column I18n.t("active_admin.description") do |cl|
                    a cl.description
                end
            end
        end
    end

    sidebar I18n.t("active_admin.network_element_details"), only: :show do
        attributes_table_for network_element do
            row I18n.t("active_admin.platform") do |ne|
                pt = Platform.find(ne.platform_id)
                link_to pt.name, admin_platform_path(pt.to_param)
            end
            row I18n.t("active_admin.system") do |ne|
                sys = System.find(ne.system_id)
                link_to sys.name, admin_system_path(sys.to_param)
            end
            row I18n.t("active_admin.type") do |ne|
                tp = Type.find(ne.type_id)
                link_to tp.name, admin_type_path(tp.to_param)
            end
            row I18n.t("active_admin.location") do |ne|
                if ne.location_id then
                    lc = Location.find(ne.location_id)
                    link_to lc.name, admin_location_path(lc.to_param)
                end
            end
            row I18n.t("active_admin.vendor") do |ne|
                if ne.vendor_id then
                    vn = Vendor.find(ne.vendor_id)
                    link_to vn.name, admin_vendor_path(vn.to_param)
                end
            end
            row I18n.t("active_admin.name") do |ne|
                ne.name
            end
            row I18n.t("active_admin.description") do |ne|
                ne.description
            end
            row :ip
            row I18n.t("active_admin.port") do |ne|
                ne.port
            end
            row I18n.t("active_admin.protocol") do |ne|
                ptc = Protocol.find(ne.protocol_id)
                link_to ptc.name, admin_protocol_path(ptc.to_param)
            end
        end
    end
end
