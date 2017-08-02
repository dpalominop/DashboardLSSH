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
    permit_params :name, :description, :network_element_id, :role_id, command_ids: [], sudo_command_ids: []

    index :title => "Commands Lists" do
        selectable_column
        #id_column
        column :name
        column :description
        column 'Network Element' do |cl|
            if cl.network_element_id then
                link_to NetworkElement.find(cl.network_element_id).name, admin_network_element_path(cl.network_element_id)
            end
        end
        column 'Role' do |cl|
            if cl.role_id then
                link_to Role.find(cl.role_id).name, admin_role_path(cl.role_id)
            end
        end
        actions
    end

    filter :name
    filter :description
    filter :network_element_id
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
            f.input :name
            f.input :description
            f.input :network_element_id, as: :select, collection: NetworkElement.all, :label => 'Network Element'
            f.input :role_id, as: :select, collection: Role.all, :label => 'Role'
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
    end

    sidebar "Commands Lists Details", only: :show do
        attributes_table_for command_list do
            row :name
            row :description
            row 'Network Element' do |cl|
                if cl.network_element_id then
                    link_to NetworkElement.find(cl.network_element_id).name, admin_network_element_path(cl.network_element_id)
                end
            end
            row 'Role' do |cl|
                if cl.role_id then
                    link_to Role.find(cl.role_id).name, admin_role_path(cl.role_id)
                end
            end
        end
    end

end
