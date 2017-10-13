class EmployeeSurveillance < ApplicationRecord
  belongs_to :employee
  belongs_to :surveillance
end
