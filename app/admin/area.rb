ActiveAdmin.register Area do
    menu :priority => 2
    permit_params :name, :description, network_element_ids: [], employee_ids: []

    index :title => "Areas" do
        selectable_column
        #id_column
        column :name
        column :description
        actions
    end

    filter :name
    filter :description

    form do |f|
        f.inputs "Area Details" do
            f.input :name
            f.input :description
            f.input :network_element_ids, as: :tags, collection: NetworkElement.all, :label => 'Network Elements'
            f.input :employee_ids, as: :tags, collection: Employee.all, :label => 'Employee'
        end
        f.actions
    end

    # show do
    #     panel "Network Elements" do
    #         table_for(area.employees) do |e|
    #             e.column :name
    #         end
    #     end
    # end

    # sidebar "Area Details", only: :show do
    #     attributes_table_for area do
    #         row :name
    #         row :description
    #     end
    # end
end
