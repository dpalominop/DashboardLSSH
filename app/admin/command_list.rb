ActiveAdmin.register CommandList do

    permit_params :name, :description, :network_element_id, :role_id, command_ids: []
    
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
