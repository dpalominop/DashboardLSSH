ActiveAdmin.register Command do
  menu :parent => I18n.t("active_admin.security_management"),
       :priority => 1

  active_admin_import validate: true,
                        template: 'import' ,
                        template_object: ActiveAdminImport::Model.new(
                            hint: I18n.t("active_admin.hint_csv_import"),
                            force_encoding: :auto,
                            csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                        ),
                        after_batch_import: ->(importer) {
                           importer.values_at('name').map { |x| x }.each do |name|
                             if Command.exists?(name: name) && not(ExcludeCommand.exists?(name: name)) && not(SudoCommand.exists?(name: name))
                               ExcludeCommand.create!(name: name)
                               SudoCommand.create!(name: name)
                             end
                           end
                        },
                        back: -> { config.namespace.resource_for(Command).route_collection_path }

  permit_params :name, :active_admin_import_model

  member_action :update, method: [:put, :patch] do
    cname = Command.where(id: params[:id]).pluck(:name)[0]
    ExcludeCommand.where(name: cname).update(name: params[:command][:name])
    SudoCommand.where(name: cname).update(name: params[:command][:name])
    update!
  end

  collection_action :create, method: [:post] do
    if params[:command] then
      ExcludeCommand.create(name: params[:command][:name])
      SudoCommand.create(name: params[:command][:name])
    end
    create!
  end

  member_action :destroy, method: [:delete] do
    cname = Command.where(id: params[:id]).pluck(:name)[0]
    ExcludeCommand.where(name: cname).destroy_all
    SudoCommand.where(name: cname).destroy_all
    destroy!
  end

  filter :name, :label => I18n.t("active_admin.name")
  filter :command_lists, :label => I18n.t("active_admin.commands_lists")
  filter :created_at, :label => I18n.t("active_admin.created_at")
  filter :updated_at, :label => I18n.t("active_admin.updated_at")

  index :title => I18n.t("active_admin.commands") do
      selectable_column
      column I18n.t("active_admin.name"), :sortable => :name do |cm|
          if cm.name then
              link_to cm.name, admin_command_path(cm.id)
          end
      end
      column I18n.t("active_admin.created_at"), :sortable => :created_at do |cm|
          if cm.created_at then
              cm.created_at
          end
      end
      column I18n.t("active_admin.updated_at"), :sortable => :updated_at do |cm|
          if cm.updated_at then
              cm.updated_at
          end
      end
      actions
  end

  show do
    panel I18n.t("active_admin.command_details") do
      attributes_table_for resource do
        row I18n.t("active_admin.command") do |res|
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
          f.input :name, :label => I18n.t("active_admin.command")
      end
      f.actions
  end
end
