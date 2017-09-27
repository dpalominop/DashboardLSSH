ActiveAdmin.register CommandList do
    menu :parent => I18n.t("active_admin.security_management"),
         :priority => 7
    active_admin_import validate: true,
                        template: 'import' ,
                        template_object: ActiveAdminImport::Model.new(
                            hint: I18n.t("active_admin.hint_csv_import"),
                            force_encoding: :auto,
                            csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                        ),
                        headers_rewrites: { 'platform' => 'platform_id',
                                            'system' => 'system_id',
                                            'type' => 'type_id',
                                            'role' => 'role_id'
                                          },
                        before_batch_import: ->(importer){
                            begin
                              platform_names = importer.values_at('platform_id')
                              platforms = Platform.where(name: platform_names).pluck(:name, :id)
                              options   = Hash[*platforms.flatten]
                              importer.batch_replace('platform_id', options)

                              system_names = importer.values_at('system_id')
                              systems = System.where(name: system_names).pluck(:name, :id)
                              options   = Hash[*systems.flatten]
                              importer.batch_replace('system_id', options)

                              type_names = importer.values_at('type_id')
                              types = Type.where(name: type_names).pluck(:name, :id)
                              options   = Hash[*types.flatten]
                              importer.batch_replace('type_id', options)

                              role_names = importer.values_at('role_id')
                              roles = Role.where(name: role_names).pluck(:name, :id)
                              options   = Hash[*roles.flatten]
                              importer.batch_replace('role_id', options)
                            rescue

                            end
                        },
                        back: -> { config.namespace.resource_for(CommandList).route_collection_path }
    permit_params :name, :description, :platform_id, :system_id, :type_id, :role_id, :all_commands, command_ids: [], exclude_command_ids: [], sudo_command_ids: []

    controller do
      def scoped_collection
        end_of_association_chain.includes(:platform, :system, :type, :role)
      end
    end

    index :title => I18n.t("active_admin.commands_lists") do
        selectable_column
        #id_column
        column I18n.t("active_admin.platform"), :sortable => 'platforms.name' do |cl|
            if cl.platform_id then
                link_to Platform.find(cl.platform_id).name, admin_platform_path(cl.platform_id)
            end
        end
        column I18n.t("active_admin.system"), :sortable => 'systems.name' do |cl|
            if cl.system_id then
                link_to System.find(cl.system_id).name, admin_system_path(cl.system_id)
            end
        end
        column I18n.t("active_admin.type"), :sortable => 'types.name' do |cl|
            if cl.type_id then
                link_to Type.find(cl.type_id).name, admin_type_path(cl.type_id)
            end
        end
        column I18n.t("active_admin.name"), :sortable => :name do |cl|
            if cl.name then
                link_to cl.name, admin_command_list_path(cl.id)
            end
        end
        column I18n.t("active_admin.role"), :sortable => 'roles.name' do |cl|
            if cl.role_id then
                link_to Role.find(cl.role_id).name, admin_role_path(cl.role_id)
            end
        end
        actions
    end

    filter :name, :label => I18n.t("active_admin.name")
    filter :role_id, :label => I18n.t("active_admin.role")

    # member_action :update, method: [:put, :patch] do
    #   logger.debug "command_list_command_sudo_ids"
    #   command_sudos_ids = params[:command_list][:command_list_command_sudo_ids]
    #   params[:command_list] = params[:command_list].except(:command_list_command_sudo_ids)
    #   CommandListCommandSudo.create(command_list_id: resource.id, command_id: command_sudos_ids)
    #   update!
    # end

    form do |f|
        f.inputs I18n.t("active_admin.commands_lists_details") do
            f.input :platform_id, as: :select, collection: Platform.all, :label => I18n.t("active_admin.platform")
            f.input :system_id, as: :select, collection: System.all, :label => I18n.t("active_admin.system")
            f.input :type_id, as: :select, collection: Type.all, :label => I18n.t("active_admin.type")
            f.input :name, :label => I18n.t("active_admin.name")
            f.input :description, :label => I18n.t("active_admin.description")
            f.input :role_id, as: :select, collection: Role.all, :label => I18n.t("active_admin.role")
            f.input :all_commands, :label => I18n.t("active_admin.all_commands")
            f.input :command_ids, as: :tags, collection: Command.all, :label => I18n.t("active_admin.permited_commands")
            f.input :exclude_command_ids, as: :tags, collection: ExcludeCommand.all, :label => I18n.t("active_admin.exclude_commands")
            # f.input :sudo_command_ids, as: :tags, collection: SudoCommand.all, :label => 'Sudo Commands'
        end
        f.actions
    end

    show do
        if command_list.all_commands then
            panel I18n.t("active_admin.permited_commands") do
                columns do
                  column id: "all_commands_column_name" do
                    span I18n.t("active_admin.name")
                  end
                  hr
                  column id: "all_commands_column" do
                    span I18n.t("active_admin.all_commands")
                  end
                end
            end

            if command_list.exclude_commands.count != 0 then
                panel I18n.t("active_admin.exclude_commands") do
                    table_for command_list.exclude_commands do
                        column I18n.t("active_admin.name") do |ec|
                          ec.name
                        end
                    end
                end
            end
        else
            panel I18n.t("active_admin.permited_commands") do
                table_for command_list.commands do
                  column I18n.t("active_admin.name") do |pc|
                    pc.name
                  end
                end
            end
        end
        if command_list.sudo_commands.count != 0 then
            panel I18n.t("active_admin.sudo_commands") do
                table_for command_list.sudo_commands do
                  column I18n.t("active_admin.name") do |sc|
                    sc.name
                  end
                end
            end
        end

        panel I18n.t("active_admin.assigned_network_elements") do
            table_for NetworkElement.where(platform: command_list.platform_id,
                                        system:command_list.system_id,
                                        type: command_list.type_id) do |ne|
                column I18n.t("active_admin.name") do |ne|
                    link_to ne.name, admin_network_element_path(ne.id)
                end
                column I18n.t("active_admin.description") do |ne|
                  ne.description
                end
            end
        end
    end

    sidebar I18n.t("active_admin.commands_lists_details"), only: :show do
        attributes_table_for command_list do
            row I18n.t("active_admin.platform") do |cl|
                link_to Platform.find(cl.platform_id).name, admin_platform_path(cl.platform_id)
            end
            row I18n.t("active_admin.system") do |cl|
                link_to System.find(cl.system_id).name, admin_system_path(cl.system_id)
            end
            row I18n.t("active_admin.type") do |cl|
                link_to Type.find(cl.type_id).name, admin_type_path(cl.type_id)
            end
            row I18n.t("active_admin.name") do |cl|
                cl.name
            end
            row I18n.t("active_admin.description") do |cl|
                cl.description
            end
            row I18n.t("active_admin.role") do |cl|
                if cl.role_id then
                    link_to Role.find(cl.role_id).name, admin_role_path(cl.role_id)
                end
            end
        end
    end

end
