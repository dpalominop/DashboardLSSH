class CommandsController < InheritedResources::Base

  private

    def command_params
      params.require(:command).permit(:name)
    end
end

