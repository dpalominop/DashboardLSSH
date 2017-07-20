ActiveAdmin.register Command do
  menu :parent => "Security Management", :priority => 1
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
    permit_params :name
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

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
