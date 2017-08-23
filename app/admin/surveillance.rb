ActiveAdmin.register Surveillance do
  menu :parent => "Employee Management", :priority => 5
  permit_params :name, :description, :leadership_id, platform_ids: [], employee_ids: []

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

  form do |f|
      f.inputs "Surveillance Details" do
          f.input :leadership_id, as: :select, collection: Leadership.all, :label => 'Leadership'
          f.input :name
          f.input :description
          f.input :platform_ids, as: :tags, collection: Platform.all, :label => 'Platforms'
          f.input :employee_ids, as: :tags, collection: Employee.all, :label => 'Employee'
      end
      f.actions
  end

  show :title => 'Surveillance' do
      panel "Platforms" do
          table_for resource.platforms do
              column 'Name' do |pl|
                  link_to pl.name, admin_platform_path(pl.id)
              end
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
