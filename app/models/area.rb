class Area < ApplicationRecord
    has_many :area_network_elements
    has_many :network_elements, through: :area_network_elements

    has_many :employees
end
