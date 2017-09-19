ActiveAdmin.register Leadership do
    menu :label => I18n.t("active_admin.leaderships"),
         :parent => I18n.t("active_admin.employee_management"),
         :priority => 4

    active_admin_import validate: true,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "Configure CSV options",
                              force_encoding: :auto,
                              csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                          ),
                          back: -> { config.namespace.resource_for(Surveillance).route_collection_path }

    permit_params :name, :description, :management_id

    # index :title => "Leadership" do
    #     selectable_column
    #     # id_column
    #     column :name
    #     column :description
    #     column :management_id
    #     actions
    # end

    filter :name
    filter :description

    # form do |f|
    #     f.inputs "Leadership Details" do
    #         f.input :management_id
    #         f.input :name
    #         f.input :description
    #         # f.input :network_element_ids, as: :tags, collection: NetworkElement.all, :label => 'Network Elements'
    #         # f.input :employee_ids, as: :tags, collection: Employee.all, :label => 'Employee'
    #     end
    #     f.actions
    # end

    # show :title => 'Leadership' do
    #     # panel "Network Elements" do
    #     #     table_for resource.network_elements do
    #     #         column 'Name' do |ne|
    #     #             link_to ne.name, admin_network_element_path(ne.id)
    #     #         end
    #     #         column :ip
    #     #         column :port
    #     #     end
    #     # end
    #
    #     # panel "Employees" do
    #     #     table_for resource.employees do
    #     #         column 'Username' do |emp|
    #     #             link_to emp.username, admin_employee_path(emp.id)
    #     #         end
    #     #         column :name
    #     #         column :document
    #     #     end
    #     # end
    # end

    # sidebar "Leadership Details", only: :show do
    #     attributes_table_for resource do
    #         row :name
    #         row :description
    #     end
    # end
end
