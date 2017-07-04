ActiveAdmin.register Area do
    permit_params :name, :description, network_element_ids: []

    index :title => "Areas" do
        selectable_column
        id_column
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
            f.input :network_element_ids, as: :check_boxes, collection: NetworkElement.all, :label => 'Network Elements'
        end
        f.actions
    end

    # show do
    #     panel "Network Elements" do
    #         table_for area.network_elements do
    #             column :name
    #             column :description
    #             column :ip
    #             column :port
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
