class EmployeesController < InheritedResources::Base

  private

    def employee_params
      params.require(:employee).permit(:name, :last_name, :username, :document, :area_id)
    end
end

