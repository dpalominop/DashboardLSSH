ActiveAdmin.register Session do
  menu :parent => "Security Management", :priority => 4
  permit_params :employee_id, :network_element_id, :server_id, :initiation, :document
  actions :index, :show

  index :title => "Sessions" do
      selectable_column
      # id_column
      column :employee_id
      column :network_element_id
      column :server_id
      column :initiation
      attachment_column :document
      actions
  end

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

  show do |ad|
    attributes_table do
      row :employee_id
      row :network_element_id
      row :server_id
      row :initiation
      attachment_row :document
        # row :document do
        #   image_tag(ad.document.url(:thumb))
        # end
      # Will display the image on show object page
    end
  end
end
