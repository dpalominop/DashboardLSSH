class RolesController < InheritedResources::Base

  private

    def role_params
      params.require(:role).permit(:name)
    end
end

