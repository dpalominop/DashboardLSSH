class NetworkElementsController < InheritedResources::Base

  private

    def network_element_params
      params.require(:network_element).permit(:name, :description, :ip, :port)
    end
end

