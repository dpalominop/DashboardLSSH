class AreasController < InheritedResources::Base

  private

    def area_params
      params.require(:area).permit(:name, :description)
    end
end

