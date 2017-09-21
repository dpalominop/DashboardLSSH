ActiveAdmin.register Session do
  menu :parent => I18n.t("active_admin.system"),
       :if => proc{ can? :manage, User}
  permit_params :employee_id, :network_element_id, :server_id, :initiation, :document
  actions :index, :show, :destroy

  index :title => I18n.t("active_admin.sessions") do
      selectable_column
      # id_column
      column I18n.t("active_admin.employee") do |se|
          if se.employee_id then
              link_to Employee.find(se.employee_id).name, admin_employee_path(se.employee_id)
          end
      end
      column I18n.t("active_admin.network_element") do |se|
          if se.network_element_id then
              link_to NetworkElement.find(se.network_element_id).name, admin_network_element_path(se.network_element_id)
          end
      end
      column I18n.t("active_admin.server") do |se|
          if se.server_id then
              link_to Server.find(se.server_id).hostname, admin_server_path(se.server_id)
          end
      end
      column :initiation
      # attachment_column :document
      column I18n.t("active_admin.document") do |se|
          if se.server_id && se.network_element_id && se.employee_id then
              link_to se.document_file_name, "https://10.123.120.195/#{se.document_file_name}"
          end
      end
      actions
  end

  filter :employee_id
  filter :network_element_id
  filter :server_id
  filter :initiation

  form do |f|
    f.inputs I18n.t("active_admin.session_details") do
      f.input :employee_id, as: :select, collection: Employee.all, :label => I18n.t("active_admin.employee")
      f.input :network_element_id, as: :select, collection: NetworkElement.all, :label => I18n.t("active_admin.network_element")
      f.input :server_id, as: :select, collection: Server.all, :label => I18n.t("active_admin.server")
      f.input :initiation, as: :date_time_picker
      f.input :document, :as => :file #, :hint => f.template.image_tag(f.object.document.url(:thumb))
      # Will preview the image when the object is edited
    end
    f.actions
  end

  show do |se|
    attributes_table do
      row I18n.t("active_admin.employee") do |se|
          if se.employee_id then
              link_to Employee.find(se.employee_id).name, admin_employee_path(se.employee_id)
          end
      end
      row I18n.t("active_admin.network_element") do |se|
          if se.network_element_id then
              link_to NetworkElement.find(se.network_element_id).name, admin_network_element_path(se.network_element_id)
          end
      end
      row I18n.t("active_admin.server") do |se|
          if se.server_id then
              link_to Server.find(se.server_id).hostname, admin_server_path(se.server_id)
          end
      end
      row :initiation
      # attachment_row :document
      row I18n.t("active_admin.document") do |se|
          if se.server_id && se.network_element_id && se.employee_id then
              link_to se.document_file_name, "https://10.123.120.195/#{se.document_file_name}"
          end
      end
    end
  end
end
