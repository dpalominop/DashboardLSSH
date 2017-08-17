ActiveAdmin.register Surveillance do
  menu :parent => "Employee Management", :priority => 5
  permit_params :name, :description, :leadership_id, network_element_ids: [], employee_ids: []

  # index :title => "Surveillance" do
  #     selectable_column
  #     # id_column
  #     column :name
  #     column :description
  #     column :leadership_id
  #     actions
  # end

  filter :name
  filter :description
  filter :network_elements

  form do |f|
      f.inputs "Surveillance Details" do
          f.input :leadership_id
          f.input :name
          f.input :description
          f.input :network_element_ids, as: :tags, collection: NetworkElement.all, :label => 'Network Elements'
          f.input :employee_ids, as: :tags, collection: Employee.all, :label => 'Employee'
      end
      f.actions
  end

  show :title => 'Surveillance' do
      panel "Network Elements" do
          table_for resource.network_elements do
              column 'Name' do |ne|
                  link_to ne.name, admin_network_element_path(ne.id)
              end
              column :ip
              column :port
          end
      end

      panel "Employees" do
          table_for resource.employees do
              column 'Username' do |emp|
                  link_to emp.username, admin_employee_path(emp.id)
              end
              column :name
              column :document
          end
      end
  end

  sidebar "Surveillance Details", only: :show do
      attributes_table_for resource do
          row :name
          row :description
      end
  end
end
