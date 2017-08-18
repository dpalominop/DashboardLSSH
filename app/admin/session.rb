ActiveAdmin.register Session do
  menu :parent => "System", :if => proc{ can? :manage, User}
  permit_params :employee_id, :network_element_id, :server_id, :initiation, :document
  actions :index, :show, :destroy

  index :title => "Sessions" do
      selectable_column
      # id_column
      column 'Employee' do |se|
          if se.employee_id then
              link_to Employee.find(se.employee_id).name, admin_employee_path(se.employee_id)
          end
      end
      column 'Network Element' do |se|
          if se.network_element_id then
              link_to NetworkElement.find(se.network_element_id).name, admin_network_element_path(se.network_element_id)
          end
      end
      column 'Server' do |se|
          if se.server_id then
              link_to Server.find(se.server_id).hostname, admin_server_path(se.server_id)
          end
      end
      column :initiation
      attachment_column :document
      actions
  end

  filter :employee_id
  filter :network_element_id
  filter :server_id
  filter :initiation

  form do |f|
    f.inputs "Session Details" do
      f.input :employee_id, as: :select, collection: Employee.all, :label => 'Employee'
      f.input :network_element_id, as: :select, collection: NetworkElement.all, :label => 'Network Element'
      f.input :server_id, as: :select, collection: Server.all, :label => 'Server'
      f.input :initiation, as: :date_time_picker
      f.input :document, :as => :file #, :hint => f.template.image_tag(f.object.document.url(:thumb))
      # Will preview the image when the object is edited
    end
    f.actions
  end

  show do |se|
    attributes_table do
      row 'Employee' do |se|
          if se.employee_id then
              link_to Employee.find(se.employee_id).name, admin_employee_path(se.employee_id)
          end
      end
      row 'Networ Element' do |se|
          if se.network_element_id then
              link_to NetworkElement.find(se.network_element_id).name, admin_network_element_path(se.network_element_id)
          end
      end
      row 'Server' do |se|
          if se.server_id then
              link_to Server.find(se.server_id).hostname, admin_server_path(se.server_id)
          end
      end
      row :initiation
      attachment_row :document
    end
  end
end
