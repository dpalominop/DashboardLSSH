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
                                area_names = importer.values_at('area_id')
                                # replacing author name with author id
                                areas   = Area.where(name: area_names).pluck(:name, :id)
                                options = Hash[*areas.flatten] # #{"Jane" => 2, "John" => 1}
                                importer.batch_replace('area_id', options) #replacing "Jane" with 1, etc
                              rescue

                              end
                          },
                          after_batch_import: ->(importer) {
                            Server.all.each do |server|
                              importer.values_at('username').map { |x| x }.each do |username|
                                if Employee.exists?(username: username)
                                  server.addUser(username: username)
                                end
                              end
                            end
                          },
                          back: -> { config.namespace.resource_for(Employee).route_collection_path }
    permit_params :name, :username, :document, :area_id, command_list_ids: []

    index :title => "Employees" do
        selectable_column
        #id_column
        column :name
        column :username
        column :document
        column 'Area' do |emp|
            if emp.area_id then
                link_to Area.find(emp.area_id).name, admin_area_path(emp.area_id)
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
    #     network_elements = AreaNetworkElement.where(area_id: params[:area_id]).pluck(:network_element_id)
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
            f.input :area_id, as: :select, collection: Area.all, :label => 'Area'
            f.input :command_list_ids, as: :tags, collection: CommandList.where(network_element_id: AreaNetworkElement.where(area_id: resource.area_id).pluck(:network_element_id)), :label => 'Command Lists'
        end
        f.actions
    end

    show title: :username do
        panel "Command Lists" do
            table_for employee.command_lists do
                column 'Name' do |cl|
                    link_to cl.name, admin_command_list_path(cl.id)
                end
                column :description
                column 'Network Element' do |cl|
                    if cl.network_element_id then
                        link_to NetworkElement.find(cl.network_element_id).name, admin_network_element_path(cl.network_element_id)
                    end
                end
            end
        end
    end

    sidebar "Employee Details", only: :show do
        attributes_table_for employee do
            row :name
            row :username
            row :document
            row 'Area' do |emp|
                if emp.area_id then
                    link_to Area.find(emp.area_id).name, admin_area_path(emp.id)
                end
            end
        end
    end

end
