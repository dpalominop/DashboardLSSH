ActiveAdmin.register Command do
  menu :parent => "Security Management", :priority => 1
  active_admin_import validate: true,
                        template: 'import' ,
                        template_object: ActiveAdminImport::Model.new(
                            hint: "Configure CSV options",
                            force_encoding: :auto,
                            csv_options: { col_sep: ",", row_sep: nil, quote_char: nil }
                        ),
                        after_batch_import: ->(importer) {
                           SudoCommand.create!(importer.values_at('name').map { |x| {name: x} })
                        },
                        back: -> { config.namespace.resource_for(Command).route_collection_path }

  permit_params :name, :active_admin_import_model

  member_action :update, method: [:put, :patch] do
    SudoCommand.find(params[:id]).update(name: params[:command][:name])
    update!
  end

  collection_action :create, method: [:post] do
    if params[:command] then
      SudoCommand.create(name: params[:command][:name])
    end
    create!
  end

  member_action :destroy, method: [:delete] do
    SudoCommand.find(params[:id]).destroy
    destroy!
  end

end
