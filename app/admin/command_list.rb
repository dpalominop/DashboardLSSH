ActiveAdmin.register CommandList do
    menu :parent => "Security Management", :priority => 2
    active_admin_import validate: true,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "Configure CSV options",
                              force_encoding: :auto,
                              csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                          ),
                          back: -> { config.namespace.resource_for(CommandList).route_collection_path }
    permit_params :name, :description, :platform_id, :system_id, :type_id, :role_id, :all_commands, command_ids: [], sudo_command_ids: []

    index :title => "Commands Lists" do
        selectable_column
        #id_column
        column 'Platform' do |cl|
            if cl.platform_id then
                link_to Platform.find(cl.platform_id).name, admin_platform_path(cl.platform_id)
            end
        end
        column 'System' do |cl|
            if cl.system_id then
                link_to System.find(cl.system_id).name, admin_system_path(cl.system_id)
            end
        end
        column 'Type' do |cl|
            if cl.type_id then
                link_to Type.find(cl.type_id).name, admin_type_path(cl.type_id)
            end
        end
        column 'Name' do |cl|
            if cl.name then
                link_to cl.name, admin_command_list_path(cl.id)
            end
        end
        column :description
        column 'Role' do |cl|
            if cl.role_id then
                link_to Role.find(cl.role_id).name, admin_role_path(cl.role_id)
            end
        end
        actions
    end

    filter :name
    filter :description
    filter :role_id

    # member_action :update, method: [:put, :patch] do
    #   logger.debug "command_list_command_sudo_ids"
    #   command_sudos_ids = params[:command_list][:command_list_command_sudo_ids]
    #   params[:command_list] = params[:command_list].except(:command_list_command_sudo_ids)
    #   CommandListCommandSudo.create(command_list_id: resource.id, command_id: command_sudos_ids)
    #   update!
    # end

    form do |f|
        f.inputs "Commands Lists Details" do
            f.input :platform_id, as: :select, collection: Platform.all, :label => 'Platform'
            f.input :system_id, as: :select, collection: System.all, :label => 'System'
            f.input :type_id, as: :select, collection: Type.all, :label => 'Type'
            f.input :name
            f.input :description
            f.input :role_id, as: :select, collection: Role.all, :label => 'Role'
            f.input :all_commands
            f.input :command_ids, as: :tags, collection: Command.all, :label => 'Commands'
            f.input :sudo_command_ids, as: :tags, collection: SudoCommand.all, :label => 'Sudo Commands'
        end
        f.actions
    end

    show do
        panel "Commands" do
            table_for command_list.commands do
                column :name
            end
        end

        panel "Sudo Commands" do
            table_for command_list.sudo_commands do
                column :name
            end
        end

        panel "Assigned Network Elements " do
            table_for NetworkElement.where(platform: command_list.platform_id,
                                        system:command_list.system_id,
                                        type: command_list.type_id) do |ne|
                column 'Name' do |ne|
                    link_to ne.name, admin_network_element_path(ne.id)
                end
                column :description
            end
        end
    end

    sidebar "Commands Lists Details", only: :show do
        attributes_table_for command_list do
            row 'Platform' do |cl|
                link_to Platform.find(cl.platform_id).name, admin_platform_path(cl.platform_id)
            end
            row 'System' do |cl|
                link_to System.find(cl.system_id).name, admin_system_path(cl.system_id)
            end
            row 'Type' do |cl|
                link_to Type.find(cl.type_id).name, admin_type_path(cl.type_id)
            end
            row :name
            row :description
            row 'Role' do |cl|
                if cl.role_id then
                    link_to Role.find(cl.role_id).name, admin_role_path(cl.role_id)
                end
            end
        end
    end

end
