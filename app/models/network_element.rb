class NetworkElement < ApplicationRecord
    has_many :area_network_elements
    has_many :areas, through: :area_network_elements

    has_many :command_lists
end
