ActiveAdmin.register Employee do
    permit_params :name, :lastname, :username, :document, :area_id, command_list_ids: []

    index :title => "Employees" do
        selectable_column
        id_column
        column :name
        column :lastname
        column :username
        column :document
        column :area_id
        actions
    end

    filter :username
    filter :document

    form do |f|
        f.inputs "Employee Details" do
            f.input :name
            f.input :lastname
            f.input :username
            f.input :document
            f.input :area_id, as: :select, collection: Area.all, :label => 'Area'
            f.input :command_list_ids, as: :tags, collection: CommandList.all, :label => 'Command Lists'
        end
        f.actions
    end

    show do
        panel "Command Lists" do
            table_for employee.command_lists do
                column :name
                column :description
                column 'Network Element' do |emp|
                    if emp.network_element_id then
                        link_to NetworkElement.find(emp.network_element_id).name, admin_network_element_path(emp.network_element_id)
                    end
                end
            end
        end
    end

    sidebar "Employee Details", only: :show do
        attributes_table_for employee do
            row :name
            row :lastname
            row :username
            row :document
            row :area_id
        end
    end

end
