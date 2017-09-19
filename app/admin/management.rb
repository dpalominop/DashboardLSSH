ActiveAdmin.register Management do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 3
  permit_params :name, :description, :direction_id

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.managements") do
      selectable_column
      column I18n.t("active_admin.direction") do |mng|
          if mng.direction_id then
              link_to Direction.find(mng.direction_id).name, admin_direction_path(mng.direction_id)
          end
      end
      column I18n.t("active_admin.name"), :sortable => :name do |mng|
          if mng.name then
              link_to mng.name, admin_management_path(mng.id)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |mng|
          if mng.created_at then
              mng.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |mng|
          if mng.updated_at then
              mng.updated_at
          end
      end
      actions
  end

  form do |f|
      f.inputs do
          f.input :direction_id, as: :select, collection: Direction.all, :label => I18n.t("active_admin.direction")
          f.input :name, :label => I18n.t("active_admin.name")
          f.input :description, :label => I18n.t("active_admin.description")
      end
      f.actions
  end
end
