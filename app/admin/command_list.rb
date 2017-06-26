ActiveAdmin.register CommandList do

    permit_params :name, :description, :network_element_id, :role_id, command_ids: []
    
    index :title => "Commands Lists" do
        selectable_column
        id_column
        column :name
        column :description
        column :network_element_id
        column :role_id
        actions
    end

    filter :name
    filter :description
    filter :network_element_id
    filter :role_id

    form do |f|
        f.inputs "Commands Lists Details" do
            f.input :name
            f.input :description
            f.input :network_element_id, as: :select, collection: NetworkElement.all, :label => 'Network Elements'
            f.input :role_id, as: :select, collection: Role.all, :label => 'Roles'
            f.input :command_ids, as: :check_boxes, collection: Command.all, :label => 'Commands'
        end
        f.actions
    end

    show do
        panel "Commands" do
            table_for command_list.commands do
                column :name
            end
        end
    end

    sidebar "Commands Lists Details", only: :show do
        attributes_table_for area do
            row :name
            row :description
            row :network_element_id
            row :role_id
        end
    end

end
