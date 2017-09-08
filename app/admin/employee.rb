ActiveAdmin.register Employee do
    menu :parent => "Employee Management"
    #menu :priority => 5
    active_admin_import validate: true,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "Configure CSV options",
                              force_encoding: :auto,
                              csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                          ),
                          before_batch_import: ->(importer){
                              begin
                                surveillance_names = importer.values_at('surveillance_id')
                                # replacing author name with author id
                                surveillances   = Surveillance.where(name: surveillance_names).pluck(:name, :id)
                                options = Hash[*surveillances.flatten] # #{"Jane" => 2, "John" => 1}
                                importer.batch_replace('surveillance_id', options) #replacing "Jane" with 1, etc
                              rescue

                              end
                          },
                          after_batch_import: ->(importer) {
                            importer.values_at('username').map { |x| x }.each do |username|
                              if Employee.exists?(username: username)
                                Server.all.each do |server|
                                  server.addUser(username: username)
                                end
                              end
                            end
                          },
                          back: -> { config.namespace.resource_for(Employee).route_collection_path }
    permit_params :name, :username, :document, :surveillance_id, command_list_ids: []

    index :title => "Employees" do
        selectable_column
        #id_column
        column 'Name' do |emp|
          if emp.name then
            link_to emp.name, admin_employee_path(emp.id)
          end
        end
        column :username
        column :document
        column 'Surveillance' do |emp|
            if emp.surveillance_id then
                link_to Surveillance.find(emp.surveillance_id).name, admin_surveillance_path(emp.surveillance_id)
            end
        end
        actions
    end

    filter :username
    filter :document

    member_action :update, method: [:put, :patch] do
      employee = Employee.find(params[:id])
      if employee.username != params[:employee][:username]
        Server.all.each do |server|
          server.delUser(username: employee.username)
          server.addUser(username: params[:employee][:username])
        end
      end
      update!
    end

    collection_action :create, method: [:post] do
      if params[:employee] then
        Server.all.each do |server|
          server.addUser(username: params[:employee][:username])
        end
      end
      create!
    end

    member_action :destroy, method: [:delete] do
      Server.all.each do |server|
        server.delUser(username: Employee.find(params[:id]).username)
      end
      destroy!
    end

    # collection_action :change_command_list, method: :get do
    #     logger.debug "************"
    #     logger.debug params
    #     network_elements = SurveillanceNetworkElement.where(surveillance_id: params[:surveillance_id]).pluck(:network_element_id)
    #     network_elements = [1]
    #     logger.debug network_elements
    #     command_lists = CommandList.where(id: network_elements)
    #     logger.debug command_lists.ids
    #     tmp = command_lists.ids
    #     logger.debug "tmp: "
    #     logger.debug tmp
    #     render json: command_lists.map { |cl| cl.as_json(only: [:id, :name]) }
    # end

    form do |f|
        f.inputs "Employee Details" do
            f.input :name
            f.input :username
            f.input :document
            f.input :surveillance_id, as: :nested_select, minimum_input_length: 0,
                  level_1: { attribute: :vice_presidency_id, collection: VicePresidency.all },
                  level_2: { attribute: :direction_id, collection: Direction.all },
                  level_3: { attribute: :management_id, collection: Management.all },
                  level_4: { attribute: :leadership_id, collection: Leadership.all },
                  level_5: { attribute: :surveillance_id, collection: Surveillance.all }
            f.input :command_list_ids, as: :tags,
                    collection: CommandList.where(platform_id:
                      PlatformSurveillance.where(surveillance_id:
                        resource.surveillance_id
                      ).pluck(:platform_id)
                    ), :label => 'Command Lists'
            # f.input :command_list_ids, as: :search_select, collection: CommandList.all,
            #       url: change_command_list_admin_employees_path,
            #       fields: [:surveillance_id], order_by: 'name_desc'
        end
        f.actions
    end

    show title: :name do
        panel "Command Lists" do
            table_for employee.command_lists do
                column 'Platform' do |cl|
                    link_to Platform.find(cl.platform_id).name, admin_platform_path(cl.platform_id)
                end
                column 'System' do |cl|
                    link_to System.find(cl.system_id).name, admin_system_path(cl.system_id)
                end
                column 'Type' do |cl|
                    link_to Type.find(cl.type_id).name, admin_type_path(cl.type_id)
                end
                column 'Name' do |cl|
                    link_to cl.name, admin_command_list_path(cl.id)
                end
                column :description
                # column 'Network Element' do |cl|
                #     if cl.network_element_id then
                #         link_to NetworkElement.find(cl.network_element_id).name, admin_network_element_path(cl.network_element_id)
                #     end
                # end
            end
        end
    end

    sidebar "Employee Details", only: :show do
        attributes_table_for employee do
            row :name
            row :username
            row :document
            row 'Surveillance' do |emp|
                if emp.surveillance_id then
                    link_to Surveillance.find(emp.surveillance_id).name, admin_surveillance_path(emp.surveillance_id)
                end
            end
        end
    end

end
