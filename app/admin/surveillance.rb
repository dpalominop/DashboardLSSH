ActiveAdmin.register Surveillance do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 5
  permit_params :name, :description, :leadership_id, platform_ids: [], employee_ids: []

  index :title => I18n.t("active_admin.surveillances") do
      selectable_column
      # id_column
      column :name
      column :description
      column I18n.t("active_admin.leadership") do |su|
        if su.leadership_id then
          link_to Leadership.find(su.leadership_id).name, admin_leadership_path(su.leadership_id)
        end
      end
      actions
  end

  filter :name
  filter :description

  form do |f|
      f.inputs I18n.t("active_admin.surveillance_details") do
          f.input :leadership_id, as: :select, collection: Leadership.all, :label => I18n.t("active_admin.leadership")
          f.input :name
          f.input :description
          f.input :platform_ids, as: :tags, collection: Platform.all, :label => I18n.t("active_admin.platforms")
          f.input :employee_ids, as: :tags, collection: Employee.all, :label => I18n.t("active_admin.employee")
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
              column :name
              column :document
          end
      end
  end

  sidebar I18n.t("active_admin.surveillance_details"), only: :show do
      attributes_table_for resource do
          row :name
          row :description
      end
  end
end
