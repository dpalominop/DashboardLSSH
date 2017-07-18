class NetworkElement < ApplicationRecord
    has_many :area_network_elements, :dependent => :destroy
    has_many :areas, through: :area_network_elements

    has_many :command_lists

    validates :ip,    :presence => true,  :uniqueness => true
end
