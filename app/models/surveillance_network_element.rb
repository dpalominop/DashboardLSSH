class SurveillanceNetworkElement < ApplicationRecord
    belongs_to :surveillance
    belongs_to :network_element
end
