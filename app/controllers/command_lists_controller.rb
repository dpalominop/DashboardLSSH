class CommandListsController < InheritedResources::Base

  private

    def command_list_params
      params.require(:command_list).permit(:name, :description, :network_element_id, :role_id)
    end
end

