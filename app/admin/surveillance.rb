ActiveAdmin.register Surveillance do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 5
  permit_params :name, :description, :leadership_id, platform_ids: [], employee_ids: []

  member_action :pdf, method: :get do
    render(pdf: "Reporte #{resource.name}")
  end

  action_item :pdf, :only => :show do
    link_to(I18n.t("active_admin.report"), pdf_admin_surveillance_path(id: resource.id))
  end

  index :title => I18n.t("active_admin.surveillances") do
      selectable_column
      # id_column
      column I18n.t("active_admin.leadership") do |su|
        if su.leadership_id then
          link_to Leadership.find(su.leadership_id).name, admin_leadership_path(su.leadership_id)
        end
      end
      column I18n.t("active_admin.name"), :sortable => :name do |su|
          if su.name then
              link_to su.name, admin_surveillance_path(su.id)
          end
      end
      actions
  end

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  form do |f|
      f.inputs I18n.t("active_admin.surveillance_details") do
          f.input :leadership_id, as: :select, collection: Leadership.all, :label => I18n.t("active_admin.leadership")
          f.input :name, :label => I18n.t("active_admin.name")
          f.input :description, :label => I18n.t("active_admin.description")
          f.input :platform_ids, as: :tags, collection: Platform.all, :label => I18n.t("active_admin.platforms")
          f.input :employee_ids, as: :tags, collection: Employee.all, :label => I18n.t("active_admin.employees")
      end
      f.actions
  end

  show :title => :name do
      panel I18n.t("active_admin.platforms") do
          table_for resource.platforms do
              column I18n.t("active_admin.name") do |pl|
                  link_to pl.name, admin_platform_path(pl.id)
              end
          end
      end

      panel I18n.t("active_admin.employees") do
          table_for resource.employees do
              column I18n.t("active_admin.username") do |emp|
                  link_to emp.username, admin_employee_path(emp.id)
              end
              column I18n.t("active_admin.name") do |emp|
                  emp.name
              end
              column I18n.t("active_admin.document") do |emp|
                  emp.document
              end
          end
      end
  end

  sidebar I18n.t("active_admin.surveillance_details"), only: :show do
      attributes_table_for resource do
          row I18n.t("active_admin.name") do |res|
              res.name
          end
          row I18n.t("active_admin.description") do |res|
              res.description
          end
      end
  end
end
