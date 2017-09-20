ActiveAdmin.register VicePresidency do
  menu :parent => I18n.t("active_admin.employee_management"),
       :priority => 1
  permit_params :name, :description

  filter :name, :label => I18n.t("active_admin.name")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.vice_presidencies") do
      selectable_column
      column I18n.t("active_admin.name"), :sortable => :name do |vp|
          if vp.name then
              link_to vp.name, admin_vice_presidency_path(vp.id)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |vp|
          if vp.created_at then
              vp.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |vp|
          if vp.updated_at then
              vp.updated_at
          end
      end
      actions
  end

  show do
    panel I18n.t("active_admin.vice_presidency_details") do
      attributes_table_for resource do
        row I18n.t("active_admin.vice_presidency") do |res|
            res.name
        end
        row I18n.t("active_admin.created_at") do |res|
            res.created_at
        end
        row I18n.t("active_admin.updated_at") do |res|
            res.created_at
        end
      end
    end
  end

  form do |f|
      f.inputs do
          f.input :name, :label => I18n.t("active_admin.name")
          f.input :description, :label => I18n.t("active_admin.description")
      end
      f.actions
  end
end
