ActiveAdmin.register Session do
  menu :parent => I18n.t("active_admin.system"),
       :if => proc{ can? :manage, User}
  permit_params :employee_id, :network_element_id, :server_id, :initiation, :document
  actions :index, :show, :destroy

  controller do
    def scoped_collection
      end_of_association_chain.includes(:employee, :network_element, :server)
    end
  end

  batch_action :destroy, confirm: I18n.t("active_admin.batch_confirm_session")  do |ids|
    ids = ids.map { |i| i.to_i }
    batch_action_collection.find(ids.flatten).each do |resource|
      resource.destroy
    end
    if ids.size == 1 then
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_session")
    else
      redirect_to collection_path, notice: I18n.t("active_admin.batch_destroy_sessions")
    end
  end

  index :title => I18n.t("active_admin.sessions") do
      selectable_column
      # id_column
      column I18n.t("active_admin.employee"), :sortable => 'employees.name' do |se|
          if se.employee_id then
              emp = Employee.find(se.employee_id)
              link_to emp.name, admin_employee_path(emp.to_param)
          end
      end
      column I18n.t("active_admin.network_element"), :sortable => 'network_elements.name' do |se|
          if se.network_element_id then
              ne = NetworkElement.find(se.network_element_id)
              link_to ne.name, admin_network_element_path(ne.to_param)
          end
      end
      column I18n.t("active_admin.server"), :sortable => 'servers.hostname' do |se|
          if se.server_id then
              sr = Server.find(se.server_id)
              link_to sr.hostname, admin_server_path(sr.to_param)
          end
      end
      column I18n.t("active_admin.initiation"), :sortable => :created_at  do |se|
          se.created_at
      end
      # attachment_column :document
      column I18n.t("active_admin.document"), :sortable => :document_file_name do |se|
          if se.server_id && se.network_element_id && se.employee_id then
              config = YAML.load_file('config/fileserver.yml')
              link_to se.document_file_name, "https://#{config['hostname']}/#{se.document_file_name}"
          end
      end
      actions
  end

  filter :employee_id, :label => I18n.t("active_admin.employee")
  filter :network_element_id, :label => I18n.t("active_admin.network_element")
  filter :server_id, :label => I18n.t("active_admin.server")
  filter :initiation, :label => I18n.t("active_admin.initiation")

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

  show :title => :document_file_name do |se|
    attributes_table do
      row I18n.t("active_admin.employee") do |se|
          if se.employee_id then
              emp = Employee.find(se.employee_id)
              link_to emp.name, admin_employee_path(emp.to_param)
          end
      end
      row I18n.t("active_admin.network_element") do |se|
          if se.network_element_id then
              ne = NetworkElement.find(se.network_element_id)
              link_to ne.name, admin_network_element_path(ne.to_param)
          end
      end
      row I18n.t("active_admin.server") do |se|
          if se.server_id then
              sr = Server.find(se.server_id)
              link_to sr.hostname, admin_server_path(sr.to_param)
          end
      end
      row I18n.t("active_admin.initiation") do |se|
          se.initiation
      end
      # attachment_row :document
      row I18n.t("active_admin.document") do |se|
          if se.server_id && se.network_element_id && se.employee_id then
              link_to se.document_file_name, "https://10.123.120.195/#{se.document_file_name}"
          end
      end
    end
  end
end
