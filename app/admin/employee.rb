ActiveAdmin.register Employee do
    menu  :parent => I18n.t("active_admin.employee_management"),
          :priority => 6

    state_action :bloquear
    state_action :desbloquear
    state_action :eliminar do
      Server.all.each do |server|
        server.delUser(username: resource.username)
      end
      resource.sessions.destroy_all
      resource.destroy
      redirect_to collection_path
    end

    active_admin_import validate: true,
                        template: 'import' ,
                        template_object: ActiveAdminImport::Model.new(
                            hint: "Configure CSV options",
                            force_encoding: :auto,
                            csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                        ),
                        headers_rewrites: { 'surveillance' => 'surveillance_id' },
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
                          Server.all.each do |server|
                            server.addUser(username: importer.values_at('username').map { |x| x if Employee.exists?(username: x)})
                          end
                        },
                        back: -> { config.namespace.resource_for(Employee).route_collection_path }
    permit_params :name, :username, :document, :status, :is_provider, :company_id, command_list_ids: [], surveillance_ids: []

    member_action :update, method: [:put, :patch] do
      employee = Employee.find(params[:id])
      if employee.username != params[:employee][:username]
        Server.all.each do |server|
          server.delUser(username: employee.username)
          server.addUser(username: params[:employee][:username])
        end
      end
      if params[:employee][:is_provider] == "0" then
        cp = Company.find_or_create_by(name: GlobalSetting.first.company)
        params[:employee][:company_id] = cp.id
      end
      update!
    end

    collection_action :create, method: [:post] do
      if params[:employee] then
        params['employee']["status"]="active"
        if params[:employee][:is_provider] == "0" then
          cp = Company.find_or_create_by(name: GlobalSetting.first.company)
          params[:employee][:company_id] = cp.id
        end
      end

      create!

      if params[:employee] && Employee.exists?(username: params[:employee][:username]) then
        Server.all.each do |server|
          server.addUser(username: params[:employee][:username])
        end
      end
    end

    member_action :destroy, method: [:delete] do
      Server.all.each do |server|
        server.delUser(username: Employee.find(params[:id]).username)
      end
      Employee.find(params[:id]).sessions.destroy_all
      destroy!
    end

    member_action :pdf, method: :get do
      render(pdf: "Reporte #{resource.username}")
    end

    action_item :pdf, :only => :show do
      link_to(I18n.t("active_admin.report"), pdf_admin_employee_path(id: resource.to_param))
    end

    controller do
      actions :all, :except => [:destroy]
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

    csv do
      column :name, humanize_name: false
      column :username, humanize_name: false
      column :document, humanize_name: false
      column :company, humanize_name: false  do |emp|
          emp.company.name
      end
      column :is_provider, humanize_name: false
      column :surveillances, humanize_name: false  do |emp|
          emp.surveillances.pluck(:name).to_param
      end
      column :status, humanize_name: false
    end

    batch_action :destroy, confirm: I18n.t("active_admin.batch_confirm_employee")  do |ids|
      usernames = ids.map { |i| Employee.find(i.to_i).username }
      Server.all.each do |server|
        server.delUser(username: usernames)
      end
      ids.each do |id|
        resource = Employee.find(id.to_i)
        resource.sessions.destroy_all
        resource.destroy
      end

      if ids.size == 1 then
        redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_employee")
      else
        redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_employees")
      end
    end

    filter :is_provider, :label => I18n.t("active_admin.is_provider")
    filter :username
    filter :document, :label => I18n.t("active_admin.document")

    index :title => I18n.t("active_admin.users") do
        selectable_column
        #id_column
        column I18n.t("active_admin.name"), :sortable => :name do |emp|
          if emp.name then
            link_to emp.name, admin_employee_path(emp.to_param)
          end
        end
        column :username
        column I18n.t("active_admin.document"), :sortable => :document do |emp|
          if emp.document then
            emp.document
          end
        end
        column I18n.t("active_admin.company"), :sortable => :document do |emp|
          if emp.company_id then
            emp.company
          end
        end
        column I18n.t("active_admin.is_provider"), :sortable => :document do |emp|
          emp.is_provider
        end
        column I18n.t("active_admin.status"), :sortable => :status do |emp|
          status_tag emp.status, label: I18n.t("active_admin.#{emp.status}")
        end
        actions
    end

    form do |f|
        f.inputs I18n.t("active_admin.employee_details") do
            f.input :name, :label => I18n.t("active_admin.name")
            f.input :username
            f.input :document, :label => I18n.t("active_admin.document")
            f.input :is_provider, :label => I18n.t("active_admin.is_provider")
            f.input :company_id, as: :select,
                    collection: Company.where.not(name: GlobalSetting.first.company),
                    :label => I18n.t("active_admin.company")
            f.input :surveillance_ids, as: :tags, width: '100%',
                    collection: Surveillance.all,
                    :label => I18n.t("active_admin.surveillances")
            f.input :command_list_ids, as: :tags, width: '100%',
                    collection: CommandList.where(platform_id:
                      PlatformSurveillance.where(surveillance_id:
                        resource.surveillance_ids
                      ).pluck(:platform_id)
                    ), :label => I18n.t("active_admin.commands_lists")
            # f.input :command_list_ids, as: :search_select, collection: CommandList.all,
            #       url: change_command_list_admin_employees_path,
            #       fields: [:surveillance_id], order_by: 'name_desc'
        end
        f.actions
    end

    show title: :name do
        if employee.status == "blocked" then
          panel I18n.t("active_admin.status") do
              columns do
                column id: "employee_status" do
                  status_tag resource.status, label: I18n.t("active_admin.#{resource.status}")
                end
              end
          end
        end

        if employee.is_provider then
          panel I18n.t("active_admin.surveillances") do
              table_for employee.surveillances do
                column I18n.t("active_admin.name") do |srv|
                  link_to srv.name, admin_surveillance_path(srv.to_param)
                end
                column I18n.t("active_admin.leadership") do |srv|
                  link_to srv.leadership.name, admin_leadership_path(srv.leadership.to_param)
                end
                column I18n.t("active_admin.management") do |srv|
                  link_to srv.leadership.management.name, admin_management_path(srv.leadership.management.to_param)
                end
              end
          end
        end

        panel I18n.t("active_admin.commands_lists") do
            table_for employee.command_lists do
                column I18n.t("active_admin.platform") do |cl|
                    pt = Platform.find(cl.platform_id)
                    link_to pt.name, admin_platform_path(pt.to_param)
                end
                column I18n.t("active_admin.system") do |cl|
                    sys = System.find(cl.system_id)
                    link_to sys.name, admin_system_path(sys.to_param)
                end
                column I18n.t("active_admin.type") do |cl|
                    tp = Type.find(cl.type_id)
                    link_to tp.name, admin_type_path(tp.to_param)
                end
                column I18n.t("active_admin.name") do |cl|
                    link_to cl.name, admin_command_list_path(cl.to_param)
                end
            end
        end
    end

    sidebar I18n.t("active_admin.user_details"), only: :show do
        attributes_table_for employee do
            row :name
            row :username
            row :document
            if not employee.is_provider then
              row I18n.t("active_admin.surveillance") do |emp|
                  if emp.surveillances.first then
                      srv = emp.surveillances.first
                      link_to srv.name, admin_surveillance_path(srv.to_param)
                  end
              end
            end
        end
    end

end
