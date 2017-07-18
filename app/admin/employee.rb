ActiveAdmin.register Employee do
    menu :parent => "Employee Management"
    #menu :priority => 5
    permit_params :name, :lastname, :username, :document, :area_id, command_list_ids: []

    index :title => "Employees" do
        selectable_column
        #id_column
        column :name
        column :lastname
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
            row :lastname
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
