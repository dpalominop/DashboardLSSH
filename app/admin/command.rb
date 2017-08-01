ActiveAdmin.register Command do
  menu :parent => "Security Management", :priority => 1
  active_admin_import validate: true,
                        template: 'import' ,
                        template_object: ActiveAdminImport::Model.new(
                            hint: "Configure CSV options",
                            force_encoding: :auto,
                            csv_options: { col_sep: ";", row_sep: nil, quote_char: nil }
                        )
    permit_params :name

  member_action :update, method: [:put, :patch] do
    SudoCommand.find(params[:id]).update(name: params[:command][:name])
    update!
  end

  member_action :create, method: [:post] do
    SudoCommand.create(name: params[:command][:name])
    create!
  end

  member_action :destroy, method: [:delete] do
    SudoCommand.find(params[:id]).destroy
    destroy!
  end

end
